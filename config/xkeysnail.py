import re
from xkeysnail.transform import *

# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    # Henkan -> Shift
    Key.HENKAN: Key.LEFT_SHIFT,

    # Katakana Hiragana -> Alt
    Key.KATAKANAHIRAGANA: Key.RIGHT_META,

    # Alt_L -> Control_R (for Ctrl+Click)
    Key.LEFT_ALT: Key.RIGHT_CTRL,

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
    K("Super-b"): K("C-left"),
    K("Super-f"): K("C-right"),

    # Emacs lines
    K("C-a"): K("home"), # TODO: Alt-C-a
    K("C-e"): K("end"),  # TODO: Alt-C-e
    K("C-k"): [K("Shift-end"), K("backspace")], # TODO: Alt-C-k

    # Alt -> Ctrl
    K("Super-a"): K("C-a"),
    K("Super-z"): K("C-z"),
    K("Super-x"): K("C-x"),
    K("Super-c"): K("C-c"),
    K("Super-v"): K("C-v"),
    K("Super-w"): K("C-w"),
    K("Super-t"): K("C-t"),
    K("Super-l"): K("C-l"),

    # actually these are vim insert mode bindings, but compatible with shell
    K("C-w"): [K("C-Shift-left"), K("delete")],

    K("C-d"): K("delete"),
    K("Super-d"): K("C-delete"),
}, "Mainly for Nocturn (but probably work arounded)")

define_keymap(lambda wm_class: wm_class in ("jetbrains-idea-ce"), {
    # Emacs basic
    #K("C-b"): K("left"),
    #K("C-f"): K("right"),
    K("C-p"): K("up"),
    K("C-n"): K("down"),

    # Emacs word
    K("Super-b"): K("C-left"),
    K("Super-f"): K("C-right"),

    # Emacs lines
    K("C-a"): K("home"), # TODO: Alt-C-a
    K("C-e"): K("end"),  # TODO: Alt-C-e
    K("C-k"): [K("Shift-end"), K("backspace")], # TODO: Alt-C-k

    # Alt -> Ctrl
    K("Super-a"): K("C-a"),
    K("Super-z"): K("C-z"),
    K("Super-x"): K("C-x"),
    #K("Super-c"): K("C-c"),
    K("Super-v"): K("C-v"),
    K("Super-w"): K("C-w"),
    K("Super-t"): K("C-t"),
    K("Super-l"): K("C-l"),

    # actually these are vim insert mode bindings, but compatible with shell
    # K("C-w"): [K("C-Shift-left"), K("delete")],

    K("C-d"): K("delete"),
    K("Super-d"): K("C-delete"),

    # workaround prefix key bug
    K("Super-r"): {
        K("KEY_3"): K("C-Super-KEY_3"),
        K("KEY_0"): K("C-Super-KEY_0"),
    },
    K("C-w"): {
        K("h"): K("C-Super-KEY_1"),
        K("l"): K("C-Super-KEY_2"),
    },
}, "IDEA keys (modified from 'Mainly for Nocturn')")

define_keymap(lambda wm_class: wm_class in ("Google-chrome", "Slack"), {
    # Emacs basic
    K("C-b"): K("left"),
    K("C-f"): K("right"),
    K("C-p"): K("up"),
    K("C-n"): K("down"),

    # Emacs word
    K("Super-b"): K("C-left"),
    K("Super-f"): K("C-right"),

    # Emacs lines
    K("C-a"): K("home"),
    K("C-e"): K("end"),
    K("C-k"): [K("Shift-end"), K("backspace")],

    # Alt -> Ctrl
    K("Super-a"): K("C-a"),
    K("Super-z"): K("C-z"),
    K("Super-x"): K("C-x"),
    K("Super-c"): K("C-c"),
    K("Super-v"): K("C-v"),
    K("Super-w"): K("C-w"),
    K("Super-t"): K("C-t"),
    K("Super-l"): K("C-l"),

    # actually these are vim insert mode bindings, but compatible with shell
    K("C-w"): [K("C-Shift-left"), K("delete")],

    # Tabs
    K("Super-o"): K("C-Shift-tab"),
    K("Super-p"): K("C-tab"),

    K("C-d"): K("delete"),
    K("Super-d"): K("C-delete"),
}, "Chrome keys (but probably work arounded)")

define_keymap(lambda wm_class: wm_class not in ("Gnome-terminal", "Nocturn"), {
    K("Super-o"): K("C-Shift-tab"),
    K("Super-p"): K("C-tab"),
    K("Super-Enter"): K("M-Enter"),
}, "Tab global + Alt simulation")

define_keymap(lambda wm_class: wm_class in ("Google-chrome"), {
    K("Super-s"): K("C-f"),
}, "Google Search")

define_keymap(lambda wm_class: wm_class in ("Gnome-terminal"), {
    K("Super-o"): K("M-o"),
    K("Super-p"): K("M-p"),
    K("Super-j"): K("M-j"),
    K("Super-k"): K("M-k"),
    K("Super-r"): K("M-r"),
    K("Super-b"): K("M-b"),
    K("Super-f"): K("M-f"),
    K("Super-d"): K("M-d"),
    K("Super-i"): K("M-i"),
    K("Super-w"): K("M-w"),
    K("Super-w"): K("M-w"),
    K("Super-t"): K("M-t"),
    K("Super-c"): K("M-c"),
    K("Super-v"): K("M-v"),
}, "Terminal")

define_keymap(lambda wm_class: wm_class in ("Nocturn"), {
    K("Super-j"): K("M-j"),
    K("Super-k"): K("M-k"),
    K("Super-o"): K("M-o"),
    K("Super-p"): K("M-p"),
    K("Super-Enter"): K("Shift-Enter"),
}, "Nocturn")

define_keymap(lambda wm_class: wm_class in ("Slack"), {
    K("Super-n"): K("C-k"),
    K("Super-k"): K("M-up"),
    K("Super-j"): K("M-down"),
    K("C-M-k"): K("Shift-Alt-up"),
    K("C-M-j"): K("Shift-Alt-down"),

    K("Super-key_1"): K("C-key_1"),
    K("Super-key_2"): K("C-key_2"),
    K("Super-key_3"): K("C-key_3"),
    K("Super-key_4"): K("C-key_4"),
    K("Super-key_5"): K("C-key_5"),
    K("Super-key_6"): K("C-key_6"),
    K("Super-key_7"): K("C-key_7"),
    K("Super-key_8"): K("C-key_8"),
    K("Super-key_9"): K("C-key_9"),
}, "Tab global2")

define_keymap(None, {
    K("C-j"): K("C-m"),
}, "SKK hack for chrome")
