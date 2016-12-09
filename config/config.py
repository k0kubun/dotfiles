import sys
import os
import datetime
import subprocess

from keyhac import *

def configure(keymap):
    # Global keymap which affects any windows
    keymap_global = keymap.defineWindowKeymap()

    # SandS
    keymap.replaceKey("Space", "RShift")
    keymap_global["D-RShift"] = "RShift"
    keymap_global["O-RShift"] = "Space"
    keymap_global["O-Space"] =  "Space"

    # Chrome
    keymap_chrome = keymap.defineWindowKeymap(app_name="com.google.Chrome")
    keymap_chrome["Cmd-O"] = "Ctrl-Shift-Tab"
    keymap_chrome["Cmd-P"] = "Ctrl-Tab"
    keymap_chrome["Cmd-S"] = "Cmd-F"

    # iTerm2
    keymap_iterm2 = keymap.defineWindowKeymap(app_name="com.googlecode.iterm2")
    keymap_iterm2["Cmd-I"] = "Alt-I"
    keymap_iterm2["Cmd-T"] = "Alt-T"
    keymap_iterm2["Cmd-O"] = "Alt-O"
    keymap_iterm2["Cmd-P"] = "Alt-P"
    keymap_iterm2["Cmd-W"] = "Alt-W"

    # Slack
    keymap_slack = keymap.defineWindowKeymap(app_name="com.tinyspeck.slackmacgap")
    keymap_slack["Cmd-N"] = "Cmd-K"
    keymap_slack["Cmd-J"] = "Alt-Down"
    keymap_slack["Cmd-K"] = "Alt-Up"
    keymap_slack["Cmd-Ctrl-J"] = "Alt-Shift-Down"
    keymap_slack["Cmd-Ctrl-K"] = "Alt-Shift-Up"

    # Application Launcher
    keymap_global["Ctrl-H"] = keymap.ActivateApplicationCommand("com.googlecode.iterm2" )
    keymap_global["Ctrl-O"] = keymap.ActivateApplicationCommand("com.tinyspeck.slackmacgap" )
    keymap_global["Ctrl-U"] = keymap.ActivateApplicationCommand("com.google.Chrome" )
