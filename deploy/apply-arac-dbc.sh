#!/bin/sh
# Write the ARAC DBC overlay into the client-data volume.
#
# mod-arac needs three DBC files that the stock client data does not contain.
# On this realm they were copied into the Docker volume by hand, which worked
# and left no trace: the volume is populated from the stock image, so anyone
# recreating it - a new machine, a pruned volume, a VPS - gets the stock files
# back and ARAC breaks quietly. Nothing in any repository recorded that the
# step had ever happened.
#
# This script is that record. Run it after the volume is first populated, and
# again any time the volume is recreated. It is idempotent.
#
# Usage:  deploy/apply-arac-dbc.sh [volume-name]
set -eu

VOLUME="${1:-${CLIENT_DATA_VOLUME:-azerothcore_ac-client-data}}"
# Docker needs a path its own daemon understands. Under Git Bash `pwd` returns
# /c/azerothcore/client, which the Windows daemon rejects, so ask for the
# native form there. Everywhere else the two are the same.
case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*) OVERLAY="$(cd "$(dirname "$0")/../client" && pwd -W)" ;;
    *)                    OVERLAY="$(cd "$(dirname "$0")/../client" && pwd)" ;;
esac

if ! docker volume inspect "$VOLUME" >/dev/null 2>&1; then
    echo "Volume '$VOLUME' does not exist. Start the stack once so the client" >&2
    echo "data is downloaded, then run this again." >&2
    exit 1
fi

echo "Applying ARAC DBC overlay to volume '$VOLUME'"

docker run --rm \
    -v "${VOLUME}:/clientdata" \
    -v "${OVERLAY}:/overlay:ro" \
    alpine:3 sh -c '
        set -eu
        test -d /clientdata/dbc || { echo "No dbc/ directory in the volume." >&2; exit 1; }
        for f in /overlay/*.dbc; do
            cp "$f" /clientdata/dbc/
        done
        # Report rather than trust: the copy is only useful if it matches.
        cd /overlay
        for f in *.dbc; do
            a=$(md5sum "$f" | cut -d" " -f1)
            b=$(md5sum "/clientdata/dbc/$f" | cut -d" " -f1)
            if [ "$a" = "$b" ]; then
                echo "  ok       $f"
            else
                echo "  MISMATCH $f" >&2
                exit 1
            fi
        done
    '

echo "Overlay applied. Restart the worldserver for it to be read."
