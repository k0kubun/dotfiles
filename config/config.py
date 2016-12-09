import sys
import os
import datetime
import subprocess

from keyhac import *

def configure(keymap):
    # Global keymap which affects any windows
    keymap_global = keymap.defineWindowKeymap()

    # SandS
    keymap.replaceKey("Space", "Shift")
    keymap_global["D-Shift"] = "Shift"
    keymap_global["O-Shift"] = "Space"
    keymap_global["O-Space"] = "Space"

    # Chrome
    keymap_chrome = keymap.defineWindowKeymap(app_name="com.google.Chrome")
    keymap_chrome["Cmd-O"] = "Ctrl-Shift-Tab"
    keymap_chrome["Cmd-P"] = "Ctrl-Tab"

    # iTerm2
    keymap_iterm2 = keymap.defineWindowKeymap(app_name="com.googlecode.iterm2")
    keymap_iterm2["Cmd-T"] = "Alt-T"
    keymap_iterm2["Cmd-O"] = "Alt-O"
    keymap_iterm2["Cmd-P"] = "Alt-P"
    keymap_iterm2["Cmd-W"] = "Alt-W"

    # Activation of specific window
    # Fn-T : Activate Terminal
    keymap_global["Ctrl-H"] = keymap.ActivateApplicationCommand("com.googlecode.iterm2" )
    keymap_global["Ctrl-O"] = keymap.ActivateApplicationCommand("com.tinyspeck.slackmacgap" )
    keymap_global["Ctrl-U"] = keymap.ActivateApplicationCommand("com.google.Chrome" )

    # # Launch subprocess or application
    # if 1:

    #     # Fn-E : Launch TextEdit
    #     keymap_global[ "Fn-E" ] = keymap.SubProcessCallCommand( [ "open", "-a", "TextEdit" ], cwd=os.environ["HOME"] )

    #     # Fn-L : Execute ls command
    #     keymap_global[ "Fn-L" ] = keymap.SubProcessCallCommand( [ "ls", "-al" ], cwd=os.environ["HOME"] )

    # TODO: emacs like bindings
    # keymap_global["Ctrl-P"] = "Up"
    # keymap_global["Ctrl-N"] = "Down"
    # keymap_global["Ctrl-F"] = "Right"
    # keymap_global["Ctrl-B"] = "Left"
    # keymap_global["Ctrl-A"] = "Home"
    # keymap_global["Ctrl-E"] = "End"
    # keymap_global["Alt-F"]  = "Alt-Right"
    # keymap_global["Alt-B"]  = "Alt-Left"
