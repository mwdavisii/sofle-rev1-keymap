OLED_ENABLE = yes
ENCODER_ENABLE = yes
CONSOLE_ENABLE = no
EXTRAKEY_ENABLE = yes
VIA_ENABLE = yes
VIAL_ENABLE = yes
ENCODER_MAP_ENABLE = yes
LTO_ENABLE = yes
RGBLIGHT_ENABLE = no
RGB_MATRIX_ENABLE = yes
QMK_SETTINGS = no
MOUSEKEY_ENABLE = yes
COMBO_ENABLE = no
KEY_OVERRIDE_ENABLE = no
CAPS_WORD_ENABLE = no
LAYER_LOCK_ENABLE = no
REPEAT_KEY_ENABLE = no

# RP2040 Pro Micro drop-in (Elite-Pi / Liatris / Helios class).
# Bakes the converter in so plain `qmk compile -kb sofle/rev1 -km mwdavisii` works.
CONVERT_TO = rp2040_ce
