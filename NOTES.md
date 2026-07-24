# Sofle Keyhive RGB — mwdavisii keymap notes

Personal keymap for my Keyhive Sofle RGB with RP2040 Pro Micro drop-in controllers.
Lives inside `vial-qmk/keyboards/sofle/rev1/keymaps/mwdavisii/` so upstream
`vial-qmk` can be pulled without conflicts.

## Build

    ./build.sh

Or manually from vial-qmk root:

    qmk compile -kb sofle/rev1 -km mwdavisii

The `CONVERT_TO = rp2040_ce` line in `rules.mk` handles the RP2040 conversion
so no `-e` flag is needed.

Output: `sofle_rev1_mwdavisii.uf2` in the vial-qmk root.

## Flash

Both halves need the same firmware.

1. Double-tap reset button on the controller — `RPI-RP2` drive mounts
2. Drop `sofle_rev1_mwdavisii.uf2` onto that drive
3. Repeat for the other half

## Post-flash gotcha (learned the hard way)

RP2040 QMK does **not** wipe EEPROM on flash the way AVR did. If the keyboard
behaves oddly after a flash (LEDs pegged solid, split going haywire, brightness
weirdness), the old EEPROM is fighting the new firmware.

**Fix:** hold the top-left key on the LEFT half while plugging USB in. Keep
holding ~5 seconds. Bootmagic clears EEPROM, keyboard reboots with fresh
defaults from `config.h`.

## Why the brightness caps in config.h

74 WS2812 LEDs at full white draw ~4A. The right half is powered *through* the
TRRS cable — thin conductors, meaningful resistance. At default brightness the
right-half MCU browns out, split serial goes garbled, OLEDs corrupt.

Cap keeps total draw well under what TRRS can deliver from a single USB port:

- `RGB_MATRIX_MAXIMUM_BRIGHTNESS 50` — hard ceiling (~20%), Vial slider maxes here
- `RGB_MATRIX_DEFAULT_VAL 40` — boot brightness
- `RGB_MATRIX_LED_PROCESS_LIMIT` / `_FLUSH_LIMIT` — stagger LED work over time

Empirically proven: with dual-USB (both halves plugged in) full brightness works
fine — that's how we confirmed brownout was the root cause vs firmware bugs.

**If you want to push brightness higher:** raise `RGB_MATRIX_MAXIMUM_BRIGHTNESS`
in steps (80, 120, 150). Watch for the "fine for 30s, then haywire" symptom —
that's the brownout returning.

## Vial layout (.vil)

The layout you edit in the Vial GUI lives in EEPROM. Save it to disk via
**File → Save Current Layout** and commit `sofle.vil` here so you can restore
after any EEPROM wipe with **File → Load Saved Layout**.

## Upstream sync

    cd ~/code/keyboards/vial-qmk
    git pull
    make git-submodule   # in case submodules moved

This keymap folder is unaffected — it's just files QMK's build system picks up.
