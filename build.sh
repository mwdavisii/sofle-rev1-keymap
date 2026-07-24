#!/usr/bin/env bash
# Build the mwdavisii Sofle firmware.
#
# Produces sofle_rev1_mwdavisii.uf2 in the vial-qmk root.
# Flash: double-tap reset on the controller, drop the .uf2 on the RPI-RP2 drive.
# Flash BOTH halves. After flashing, hold the top-left key while plugging in
# USB to clear EEPROM — RP2040 doesn't wipe EEPROM on flash the way AVR does.
#
# Run from anywhere; the script cd's into vial-qmk first.

set -euo pipefail

# Resolve vial-qmk root regardless of where the script is called from.
# Script lives at: <vial-qmk>/keyboards/sofle/rev1/keymaps/mwdavisii/build.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
QMK_ROOT="$(cd "$SCRIPT_DIR/../../../../.." && pwd)"

cd "$QMK_ROOT"

echo "Building sofle/rev1:mwdavisii in $QMK_ROOT"
qmk compile -kb sofle/rev1 -km mwdavisii

echo
echo "Firmware built. Next steps:"
echo "  1. Double-tap reset on the LEFT half, drop sofle_rev1_mwdavisii.uf2 on RPI-RP2"
echo "  2. Double-tap reset on the RIGHT half, drop the same file"
echo "  3. If behavior looks stale, hold TOP-LEFT key while plugging in USB to clear EEPROM"
