# mwdavisii — Sofle RGB (rev1) Vial keymap

My personal Vial keymap for the **[Keyhive Sofle RGB](https://keyhive.xyz/shop/sofle)** —
a 6×4+5 column-staggered split with two rotary encoders, dual OLEDs, and 74 WS2812
per-key LEDs. Built with Kailh Choc low-profile switches and MBK Choc keycaps.

![Sofle rev1 with Choc keys](https://i.imgur.com/WH9OoWuh.jpg)

*(Reference photo — Keyhive Sofle RGB. Swap in a photo of your own build if you want.)*

## What's in here

| File          | Purpose                                                        |
| ------------- | -------------------------------------------------------------- |
| `keymap.c`    | Compile-time layout + per-layer LED tint hook                  |
| `oled.c`      | Left OLED status column; right OLED aurora landscape           |
| `config.h`    | RGB Matrix brightness caps (see NOTES) + Vial identity         |
| `rules.mk`    | Feature flags + `CONVERT_TO = rp2040_ce` for RP2040 controller |
| `sofle.vil`   | My saved Vial layout — tap-dance auto-pairs, Hyper, macros     |
| `vial.json`   | Vial's layout metadata (from upstream)                         |
| `build.sh`    | One-shot build script                                          |
| `NOTES.md`    | Setup gotchas, brownout diagnosis, EEPROM clearing             |

## Prerequisites

- **[vial-qmk](https://github.com/vial-kb/vial-qmk)** cloned locally with submodules
  initialized (`make git-submodule`)
- QMK CLI (`qmk` on your PATH)
- An RP2040 Pro Micro drop-in in the "community edition" pinout family
  (Elite-Pi, Helios, Liatris, etc.)

## Install

Drop this folder into a vial-qmk clone at
`keyboards/sofle/rev1/keymaps/mwdavisii/`, then:

```sh
./build.sh
# or
qmk compile -kb sofle/rev1 -km mwdavisii
```

Produces `sofle_rev1_mwdavisii.uf2`. Flash both halves by double-tapping reset
on each controller and dragging the `.uf2` onto the `RPI-RP2` drive that appears.

After flashing, **hold the top-left key on the left half while plugging USB in**
to clear EEPROM. RP2040 QMK doesn't wipe EEPROM on flash the way AVR does — this
step is easy to skip and confusing to debug. Read `NOTES.md` for the full story.

Restore Vial GUI settings: open Vial → **File → Load Saved Layout** → pick `sofle.vil`.

## Highlights

- **Hyper key** — `LCAG(KC_NO)` on both thumb keys; sends Ctrl+Alt+GUI when held
- **Tap-dance auto-pairs** — double-tap `'` or `[` to type the pair and step back
  one character (works for `"` under shift too)
- **Per-layer LED tint** — base runs your chosen animation; Lower=green, Upper=blue, Nav=magenta
- **OLED HYPR badge** — inverted "HYPR" appears the moment Hyper is held
- **Live WPM** on the left OLED

## Credits

- Josef Adamcik — original [Sofle design](https://github.com/josefadamcik/SofleKeyboard)
- Keyhive — RGB variant and PCB revisions
- Drew Petersen — Vial support for the Sofle
- Solartempest — aurora landscape OLED bitmap
- QMK & Vial communities
