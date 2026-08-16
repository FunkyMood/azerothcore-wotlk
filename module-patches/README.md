# Module patches

Changes to modules whose upstream this project does not fork. Each file is
`git diff` output, applied from inside the module's directory:

    cd modules/BreakingNewsOverride
    git apply ../../module-patches/BreakingNewsOverride.patch

## BreakingNewsOverride

Three lines, and the module does not compile without them. Its upstream
was written against an older AzerothCore: `StringFormatFmt` has since been
renamed to `StringFormat`, and `CanPacketSend` now takes `WorldPacket const&`
rather than `WorldPacket&`, so the override no longer matches the virtual it
claims to override.

A patch rather than a fork because the change is small and belongs upstream
anyway. The cost is that it must be applied by hand after cloning - forking
`AnchyDev/BreakingNewsOverride` and pointing the module at it would remove
that step.
