import sys
import os
import datetime
import subprocess

from keyhac import *

def configure(keymap):
    # # Key replacement and modifier key definition
    # if 1:
    #     # Replacing Right-Shift key with BackSpace
    #     keymap.replaceKey( "RShift", "Back" )

    #     # Replacing Right-Alt key with virtual keycode 255
    #     keymap.replaceKey( "RAlt", 255 )

    #     # Defining virtual keycode 255 as User-modifier-0
    #     keymap.defineModifier( 255, "User0" )

    # Global keymap which affects any windows
    keymap_global = keymap.defineWindowKeymap()

    # # Sample of one-shot modifier
    # # IME swtiching by Right-Command key
    # if 1:
    #     keymap_global[ "O-RCmd" ] = "Ctrl-Space"

    # # TextEdit key customization
    # if 1:
    #     keymap_textedit = keymap.defineWindowKeymap( app_name="com.apple.TextEdit" )

    #     keymap_textedit[ "Cmd-R" ] = "Alt-Cmd-F"                   # 置換
    #     keymap_textedit[ "Cmd-L" ] = "Cmd-Right", "Cmd-Shift-Left" # 行選択

    # # Customize TextEdit as Emacs-ish (as an example of multi-stroke key customization)
    # if 1:

    #     # Define Ctrl-X as the first key of multi-stroke keys
    #     keymap_textedit[ "Ctrl-X" ] = keymap.defineMultiStrokeKeymap("Ctrl-X")

    #     keymap_textedit[ "Ctrl-P" ] = "Up"                  # Move cursor up
    #     keymap_textedit[ "Ctrl-N" ] = "Down"                # Move cursor down
    #     keymap_textedit[ "Ctrl-F" ] = "Right"               # Move cursor right
    #     keymap_textedit[ "Ctrl-B" ] = "Left"                # Move cursor left
    #     keymap_textedit[ "Ctrl-A" ] = "Home"                # Move to beginning of line
    #     keymap_textedit[ "Ctrl-E" ] = "End"                 # Move to end of line
    #     keymap_textedit[ "Alt-F" ] = "Alt-Right"            # Word right
    #     keymap_textedit[ "Alt-B" ] = "Alt-Left"             # Word left
    #     keymap_textedit[ "Ctrl-V" ] = "PageDown"            # Page down
    #     keymap_textedit[ "Alt-V" ] = "PageUp"               # page up
    #     keymap_textedit[ "Ctrl-X" ][ "Ctrl-F" ] = "Cmd-O"   # Open file
    #     keymap_textedit[ "Ctrl-X" ][ "Ctrl-S" ] = "Cmd-S"   # Save
    #     keymap_textedit[ "Ctrl-X" ][ "U" ] = "Cmd-Z"        # Undo
    #     keymap_textedit[ "Ctrl-S" ] = "Cmd-F"               # Search
    #     keymap_textedit[ "Ctrl-X" ][ "H" ] = "Cmd-A"        # Select all
    #     keymap_textedit[ "Ctrl-W" ] = "Cmd-X"               # Cut
    #     keymap_textedit[ "Alt-W" ] = "Cmd-C"                # Copy
    #     keymap_textedit[ "Ctrl-Y" ] = "Cmd-V"               # Paste
    #     keymap_textedit[ "Ctrl-X" ][ "Ctrl-C" ] = "Cmd-W"   # Exit


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
