#!/bin/sh
# Clone every module at the commit this realm was built against.
#
# The modules are ordinary clones inside modules/, not submodules, so nothing
# in a checkout says which commit each one should be at. On the machine that
# has been running for months that never matters; on a new one it decides
# whether the server behaves the same way, and it decides silently.
#
# modules.lock is that record, generated from the machine that works. Run this
# after cloning the server repository and before building.
#
# Usage:  deploy/clone-modules.sh [path-to-modules.lock]
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOCK="${1:-$ROOT/modules.lock}"

[ -f "$LOCK" ] || { echo "No manifest at $LOCK" >&2; exit 1; }

# Tabs separate the fields; comments and blank lines are skipped.
sed -e 's/#.*//' -e '/^[[:space:]]*$/d' "$LOCK" | while IFS="$(printf '\t')" read -r name url commit; do
    [ -n "${name:-}" ] && [ -n "${url:-}" ] && [ -n "${commit:-}" ] || continue
    dir="$ROOT/modules/$name"

    if [ -d "$dir/.git" ]; then
        echo "  $name: already present, fetching"
        git -C "$dir" fetch --quiet origin
    else
        echo "  $name: cloning"
        git clone --quiet "$url" "$dir"
    fi

    # Detached at the recorded commit, deliberately: a branch would drift the
    # next time someone pulled.
    #
    # On a machine where you also *edit* a module this is a trap - mod-ale and
    # mod-challenge-modes carry patched branches, and running this leaves them
    # detached at the same commit, so the next commit lands nowhere. Switch
    # back with `git -C modules/<name> switch <branch>` afterwards. On a server
    # that only runs what it is given, detached is exactly right.
    git -C "$dir" checkout --quiet "$commit"

    at=$(git -C "$dir" rev-parse HEAD)
    if [ "$at" = "$commit" ]; then
        echo "         at ${commit%"${commit#???????}"}"
    else
        echo "         WANTED $commit BUT GOT $at" >&2
        exit 1
    fi
done

echo "All modules at their recorded commits."
