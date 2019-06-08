import re
from xkeysnail.transform import *

# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    # Henkan -> Shift
    Key.HENKAN: Key.LEFT_SHIFT,

    # Katakana Hiragana -> Alt
    Key.KATAKANAHIRAGANA: Key.RIGHT_ALT,

    # Alt_L <-> Control_R
    Key.LEFT_ALT: Key.RIGHT_CTRL,
    Key.RIGHT_CTRL: Key.LEFT_ALT,

    # Muhenkan -> Control_L
    Key.MUHENKAN: Key.LEFT_CTRL,

    # CapsLock -> Escape
    Key.CAPSLOCK: Key.ESC,

    # Backslash -> Underscore (Without Shift, Like MacBook)
    # Key.RO: Key.RO,
})

define_keymap(lambda wm_class: wm_class not in ("Google-chrome", "Slack", "Gnome-terminal", "jetbrains-idea-ce"), {
    # Emacs basic
    K("C-b"): K("left"),
    K("C-f"): K("right"),
    K("C-p"): K("up"),
    K("C-n"): K("down"),

    # Emacs word
    K("M-b"): K("C-left"),
    K("M-f"): K("C-right"),

    # Emacs lines
    K("C-a"): K("home"), # TODO: Alt-C-a
    K("C-e"): K("end"),  # TODO: Alt-C-e
    K("C-k"): [K("Shift-end"), K("backspace")], # TODO: Alt-C-k

    # Alt -> Ctrl
    K("M-a"): K("C-a"),
    K("M-z"): K("C-z"),
    K("M-x"): K("C-x"),
    K("M-c"): K("C-c"),
    K("M-v"): K("C-v"),
    K("M-w"): K("C-w"),
    K("M-t"): K("C-t"),
    K("M-l"): K("C-l"),

    # actually these are vim insert mode bindings, but compatible with shell
    K("C-w"): [K("C-Shift-left"), K("delete")],

    K("C-d"): K("delete"),
    K("M-d"): K("C-delete"),
}, "Mainly for Nocturn (but probably work arounded)")

define_keymap(lambda wm_class: wm_class in ("jetbrains-idea-ce"), {
    # Emacs basic
    #K("C-b"): K("left"),
    #K("C-f"): K("right"),
    K("C-p"): K("up"),
    K("C-n"): K("down"),

    # Emacs word
    K("M-b"): K("C-left"),
    K("M-f"): K("C-right"),

    # Emacs lines
    K("C-a"): K("home"), # TODO: Alt-C-a
    K("C-e"): K("end"),  # TODO: Alt-C-e
    K("C-k"): [K("Shift-end"), K("backspace")], # TODO: Alt-C-k

    # Alt -> Ctrl
    K("M-a"): K("C-a"),
    K("M-z"): K("C-z"),
    K("M-x"): K("C-x"),
    #K("M-c"): K("C-c"),
    K("M-v"): K("C-v"),
    K("M-w"): K("C-w"),
    K("M-t"): K("C-t"),
    K("M-l"): K("C-l"),

    # actually these are vim insert mode bindings, but compatible with shell
    K("C-w"): [K("C-Shift-left"), K("delete")],

    K("C-d"): K("delete"),
    K("M-d"): K("C-delete"),

    # workaround prefix key bug
    K("M-r"): {
        K("KEY_3"): K("C-M-KEY_3"),
        K("KEY_0"): K("C-M-KEY_0"),
    },
}, "IDEA keys (modified from 'Mainly for Nocturn')")

define_keymap(lambda wm_class: wm_class in ("Google-chrome", "Slack"), {
    # Emacs basic
    K("C-b"): K("left"),
    K("C-f"): K("right"),
    K("C-p"): K("up"),
    K("C-n"): K("down"),

    # Emacs word
    K("M-b"): K("C-left"),
    K("M-f"): K("C-right"),

    # Emacs lines
    K("C-a"): K("home"),
    K("C-e"): K("end"),
    K("C-k"): [K("Shift-end"), K("backspace")],

    # Alt -> Ctrl
    K("M-a"): K("C-a"),
    K("M-z"): K("C-z"),
    K("M-x"): K("C-x"),
    K("M-c"): K("C-c"),
    K("M-v"): K("C-v"),
    K("M-w"): K("C-w"),
    K("M-t"): K("C-t"),
    K("M-l"): K("C-l"),

    # actually these are vim insert mode bindings, but compatible with shell
    K("C-w"): [K("C-Shift-left"), K("delete")],

    # Tabs
    K("M-o"): K("C-Shift-tab"),
    K("M-p"): K("C-tab"),

    K("C-d"): K("delete"),
    K("M-d"): K("C-delete"),
}, "Chrome keys (but probably work arounded)")

define_keymap(lambda wm_class: wm_class not in ("Gnome-terminal", "Nocturn"), {
    K("M-o"): K("C-Shift-tab"),
    K("M-p"): K("C-tab"),
}, "Tab global")

define_keymap(lambda wm_class: wm_class in ("Google-chrome"), {
    K("M-s"): K("C-f"),
}, "Google Search")

define_keymap(lambda wm_class: wm_class in ("Slack"), {
    K("M-n"): K("C-k"),
    K("M-k"): K("M-up"),
    K("M-j"): K("M-down"),
    K("C-M-k"): K("Shift-Alt-up"),
    K("C-M-j"): K("Shift-Alt-down"),

    K("M-key_1"): K("C-key_1"),
    K("M-key_2"): K("C-key_2"),
    K("M-key_3"): K("C-key_3"),
    K("M-key_4"): K("C-key_4"),
    K("M-key_5"): K("C-key_5"),
    K("M-key_6"): K("C-key_6"),
    K("M-key_7"): K("C-key_7"),
    K("M-key_8"): K("C-key_8"),
    K("M-key_9"): K("C-key_9"),
}, "Tab global2")
