import sys
import os
import datetime
import subprocess

from keyhac import *


def configure(keymap):

    # --------------------------------------------------------------------
    # Text editer setting for editting config.py file

    # Setting with program file path (Simple usage)
    if 1:
        keymap.editor = "TextEdit"
        #keymap.editor = "Sublime Text 2"

    # Setting with callable object (Advanced usage)
    if 0:
        def editor(path):
            subprocess.call([ "open", "-a", "TextEdit", path ])
        keymap.editor = editor


    # --------------------------------------------------------------------
    # Customizing the display

    # Font
    keymap.setFont( "Osaka-Mono", 16 )

    # Theme
    keymap.setTheme("black")


    # --------------------------------------------------------------------

    # Key replacement and modifier key definition
    if 1:
        # Replacing Right-Shift key with BackSpace
        keymap.replaceKey( "RShift", "Back" )

        # Replacing Right-Alt key with virtual keycode 255
        keymap.replaceKey( "RAlt", 255 )

        # Defining virtual keycode 255 as User-modifier-0
        keymap.defineModifier( 255, "User0" )


    # Global keymap which affects any windows
    keymap_global = keymap.defineWindowKeymap()


    # Fn-A : Sample of assigning callable object to key
    if 1:
        def command_HelloWorld():
            print("Hello World!")

        keymap_global["Fn-A"] = command_HelloWorld


    # Moving active window by keyboard
    if 1:
        # Ctrl-Alt-Up/Down/Left/Right : Move active window by 10 pixel unit
        keymap_global[ "Ctrl-Alt-Left"  ] = keymap.MoveWindowCommand( -10, 0 )
        keymap_global[ "Ctrl-Alt-Right" ] = keymap.MoveWindowCommand( +10, 0 )
        keymap_global[ "Ctrl-Alt-Up"    ] = keymap.MoveWindowCommand( 0, -10 )
        keymap_global[ "Ctrl-Alt-Down"  ] = keymap.MoveWindowCommand( 0, +10 )

        # Ctrl-Alt-Shift-Up/Down/Left/Right : Move active window by 1 pixel unit
        keymap_global[ "Ctrl-Alt-Shift-Left"  ] = keymap.MoveWindowCommand( -1, 0 )
        keymap_global[ "Ctrl-Alt-Shift-Right" ] = keymap.MoveWindowCommand( +1, 0 )
        keymap_global[ "Ctrl-Alt-Shift-Up"    ] = keymap.MoveWindowCommand( 0, -1 )
        keymap_global[ "Ctrl-Alt-Shift-Down"  ] = keymap.MoveWindowCommand( 0, +1 )

        # Ctrl-Alt-Cmd-Up/Down/Left/Right : Move active window to screen edges
        keymap_global[ "Ctrl-Alt-Cmd-Left"  ] = keymap.MoveWindowToMonitorEdgeCommand(0)
        keymap_global[ "Ctrl-Alt-Cmd-Right" ] = keymap.MoveWindowToMonitorEdgeCommand(2)
        keymap_global[ "Ctrl-Alt-Cmd-Up"    ] = keymap.MoveWindowToMonitorEdgeCommand(1)
        keymap_global[ "Ctrl-Alt-Cmd-Down"  ] = keymap.MoveWindowToMonitorEdgeCommand(3)


    # Sample of one-shot modifier
    # IME swtiching by Right-Command key
    if 1:
        keymap_global[ "O-RCmd" ] = "Ctrl-Space"


    # Keyboard macro
    if 1:
        keymap_global[ "Fn-0" ] = keymap.command_RecordToggle
        keymap_global[ "Fn-1" ] = keymap.command_RecordStart
        keymap_global[ "Fn-2" ] = keymap.command_RecordStop
        keymap_global[ "Fn-3" ] = keymap.command_RecordPlay
        keymap_global[ "Fn-4" ] = keymap.command_RecordClear


    # TextEdit key customization
    if 1:
        keymap_textedit = keymap.defineWindowKeymap( app_name="com.apple.TextEdit" )

        keymap_textedit[ "Cmd-R" ] = "Alt-Cmd-F"                   # 置換
        keymap_textedit[ "Cmd-L" ] = "Cmd-Right", "Cmd-Shift-Left" # 行選択


    # Customize TextEdit as Emacs-ish (as an example of multi-stroke key customization)
    if 1:

        # Define Ctrl-X as the first key of multi-stroke keys
        keymap_textedit[ "Ctrl-X" ] = keymap.defineMultiStrokeKeymap("Ctrl-X")

        keymap_textedit[ "Ctrl-P" ] = "Up"                  # Move cursor up
        keymap_textedit[ "Ctrl-N" ] = "Down"                # Move cursor down
        keymap_textedit[ "Ctrl-F" ] = "Right"               # Move cursor right
        keymap_textedit[ "Ctrl-B" ] = "Left"                # Move cursor left
        keymap_textedit[ "Ctrl-A" ] = "Home"                # Move to beginning of line
        keymap_textedit[ "Ctrl-E" ] = "End"                 # Move to end of line
        keymap_textedit[ "Alt-F" ] = "Alt-Right"            # Word right
        keymap_textedit[ "Alt-B" ] = "Alt-Left"             # Word left
        keymap_textedit[ "Ctrl-V" ] = "PageDown"            # Page down
        keymap_textedit[ "Alt-V" ] = "PageUp"               # page up
        keymap_textedit[ "Ctrl-X" ][ "Ctrl-F" ] = "Cmd-O"   # Open file
        keymap_textedit[ "Ctrl-X" ][ "Ctrl-S" ] = "Cmd-S"   # Save
        keymap_textedit[ "Ctrl-X" ][ "U" ] = "Cmd-Z"        # Undo
        keymap_textedit[ "Ctrl-S" ] = "Cmd-F"               # Search
        keymap_textedit[ "Ctrl-X" ][ "H" ] = "Cmd-A"        # Select all
        keymap_textedit[ "Ctrl-W" ] = "Cmd-X"               # Cut
        keymap_textedit[ "Alt-W" ] = "Cmd-C"                # Copy
        keymap_textedit[ "Ctrl-Y" ] = "Cmd-V"               # Paste
        keymap_textedit[ "Ctrl-X" ][ "Ctrl-C" ] = "Cmd-W"   # Exit


    # Activation of specific window
    if 1:
        # Fn-T : Activate Terminal
        keymap_global[ "Fn-T" ] = keymap.ActivateApplicationCommand( "com.apple.Terminal" )


    # Launch subprocess or application
    if 1:

        # Fn-E : Launch TextEdit
        keymap_global[ "Fn-E" ] = keymap.SubProcessCallCommand( [ "open", "-a", "TextEdit" ], cwd=os.environ["HOME"] )

        # Fn-L : Execute ls command
        keymap_global[ "Fn-L" ] = keymap.SubProcessCallCommand( [ "ls", "-al" ], cwd=os.environ["HOME"] )


    # Fn-S : サブスレッド処理のテスト
    if 1:
        def command_JobTest():

            # サブスレッドで呼ばれる処理
            def jobTest(job_item):
                subprocess.call([ "open", "-a", "Notes" ])

            # サブスレッド処理が完了した後にメインスレッドで呼ばれる処理
            def jobTestFinished(job_item):
                print( "Done." )

            job_item = JobItem( jobTest, jobTestFinished )
            JobQueue.defaultQueue().enqueue(job_item)

        keymap_global[ "Fn-N" ] = command_JobTest


    # --------------------------------------------------------------------
    # Clipboard related customization
    if 1:
        keymap_global[ "Fn-Z"       ] = keymap.command_ClipboardList      # Open the clipboard history list
        keymap_global[ "Fn-X"       ] = keymap.command_ClipboardRotate    # Move the most recent history to tail
        keymap_global[ "Fn-Shift-X" ] = keymap.command_ClipboardRemove    # Remove the most recent history
        keymap.quote_mark = "> "                                          # Mark for quote pasting

        # Maximum number of clipboard history (Default:1000)
        keymap.clipboard_history.maxnum = 1000

        # Total maximum size of clipboard history (Default:10MB)
        keymap.clipboard_history.quota = 10*1024*1024


    # Customizing clipboard history list
    if 1:

        # Fixed phrases
        fixed_items = [
            ( "name@server.net",     "name@server.net" ),
            ( "Address",             "San Francisco, CA 94128" ),
            ( "Phone number",        "03-4567-8901" ),
        ]

        # Return formatted date-time string
        def dateAndTime(fmt):
            def _dateAndTime():
                return datetime.datetime.now().strftime(fmt)
            return _dateAndTime

        # Date-time
        datetime_items = [
            ( "YYYY/MM/DD HH:MM:SS",   dateAndTime("%Y/%m/%d %H:%M:%S") ),
            ( "YYYY/MM/DD",            dateAndTime("%Y/%m/%d") ),
            ( "HH:MM:SS",              dateAndTime("%H:%M:%S") ),
            ( "YYYYMMDD_HHMMSS",       dateAndTime("%Y%m%d_%H%M%S") ),
            ( "YYYYMMDD",              dateAndTime("%Y%m%d") ),
            ( "HHMMSS",                dateAndTime("%H%M%S") ),
        ]

        # Add quote mark to current clipboard contents
        def quoteClipboardText():
            s = getClipboardText()
            lines = s.splitlines(True)
            s = ""
            for line in lines:
                s += keymap.quote_mark + line
            return s

        # Indent current clipboard contents
        def indentClipboardText():
            s = getClipboardText()
            lines = s.splitlines(True)
            s = ""
            for line in lines:
                if line.lstrip():
                    line = " " * 4 + line
                s += line
            return s

        # Unindent current clipboard contents
        def unindentClipboardText():
            s = getClipboardText()
            lines = s.splitlines(True)
            s = ""
            for line in lines:
                for i in range(4+1):
                    if i>=len(line) : break
                    if line[i]=='\t':
                        i+=1
                        break
                    if line[i]!=' ':
                        break
                s += line[i:]
            return s

        full_width_chars = "ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ！”＃＄％＆’（）＊＋，−．／：；＜＝＞？＠［￥］＾＿‘｛｜｝～０１２３４５６７８９　"
        half_width_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&'()*+,-./:;<=>?@[\]^_`{|}～0123456789 "

        # Convert to half-with characters
        def toHalfWidthClipboardText():
            s = getClipboardText()
            s = s.translate(str.maketrans(full_width_chars,half_width_chars))
            return s

        # Convert to full-with characters
        def toFullWidthClipboardText():
            s = getClipboardText()
            s = s.translate(str.maketrans(half_width_chars,full_width_chars))
            return s

        # Save the clipboard contents as a file in Desktop directory
        def command_SaveClipboardToDesktop():

            text = getClipboardText()
            if not text: return

            # Convert to utf-8 / CR-LF
            utf8_bom = b"\xEF\xBB\xBF"
            text = text.replace("\r\n","\n")
            text = text.replace("\r","\n")
            text = text.replace("\n","\r\n")
            text = text.encode( encoding="utf-8" )

            # Save in Desktop directory
            fullpath = os.path.join( getDesktopPath(), datetime.datetime.now().strftime("clip_%Y%m%d_%H%M%S.txt") )
            fd = open( fullpath, "wb" )
            fd.write(utf8_bom)
            fd.write(text)
            fd.close()

            # Open by the text editor
            keymap.editTextFile(fullpath)

        # Menu item list
        other_items = [
            ( "Quote clipboard",            quoteClipboardText ),
            ( "Indent clipboard",           indentClipboardText ),
            ( "Unindent clipboard",         unindentClipboardText ),
            ( "",                           None ),
            ( "To Half-Width",              toHalfWidthClipboardText ),
            ( "To Full-Width",              toFullWidthClipboardText ),
            ( "",                           None ),
            ( "Save clipboard to Desktop",  command_SaveClipboardToDesktop ),
            ( "",                           None ),
            ( "Edit config.py",             keymap.command_EditConfig ),
            ( "Reload config.py",           keymap.command_ReloadConfig ),
        ]

        # Clipboard history list extensions
        keymap.cblisters += [
            ( "Fixed phrase", cblister_FixedPhrase(fixed_items) ),
            ( "Date-time", cblister_FixedPhrase(datetime_items) ),
            ( "Others", cblister_FixedPhrase(other_items) ),
        ]
