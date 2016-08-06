import XMonad
import XMonad.Actions.WindowGo
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Layout.Gaps
import XMonad.Layout.SimplestFloat
import XMonad.Layout.BorderResize
import XMonad.Layout.PerWorkspace
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.WorkspaceScreenshot
import System.IO
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map as M

main :: IO ()
main = do
  initCapturing
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad $ defaults
    { manageHook  = myManageHook
    , layoutHook  = myLayoutHook
    , startupHook = startup
    , logHook     = myLogHook xmproc
    }

myManageHook = manageHook defaultConfig
                 <+>
                 manageDocks
                 -- <+>
                 -- composeAll
                 --   [ title =? "urxvt" --> doFloat ]

myLayoutHook = onWorkspace "1" (borderResize $ simplestFloat) $
               gaps [(U,30)] $
               layoutHook defaultConfig

myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

colorBlue      = "#857da9"
colorGreen     = "#88b986"
colorGray      = "#676767"
colorWhite     = "#d3d7cf"
colorGrayAlt   = "#313131"
colorNormalbg  = "#1a1e1b"

wsPP = xmobarPP { ppOrder               = \(ws:l:t:_)   -> [ws,t]
                , ppCurrent             = xmobarColor   colorGreen       colorNormalbg
                , ppUrgent              = xmobarColor   colorWhite       colorNormalbg
                , ppVisible             = xmobarColor   colorWhite       colorNormalbg
                , ppHidden              = xmobarColor   colorWhite       colorNormalbg
                , ppHiddenNoWindows     = xmobarColor   colorGray        colorNormalbg
                , ppTitle               = xmobarColor   colorWhite       colorNormalbg
                , ppWsSep               = ""
                , ppSep                 = "  ::: "
                }

defaults = defaultConfig
  { terminal = "urxvt"
  , keys = myKeys
  , borderWidth = 2
  , focusedBorderColor = "cyan"
  }

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  -- launching and killing programs
  [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
  , ((modMask,               xK_space ), spawn "dmenu_run -fn 'Inconsolata-18'") -- %! Launch dmenu
  , ((modMask .|. shiftMask, xK_c     ), kill) -- %! Close the focused window

  , ((modMask .|. shiftMask, xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
  -- , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

  , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

  , ((controlMask, xK_h), runOrRaise "urxvt" (className =? "URxvt"))
  , ((controlMask, xK_u), runOrRaise "google-chrome-stable" (className =? "google-chrome"))
  , ((controlMask, xK_o), runOrRaise "nocturn" (className =? "nocturn"))

  -- move focus up or down the window stack
  , ((modMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
  , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
  -- , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
  -- , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
  , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

  -- modifying the window order
  , ((modMask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
  , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
  , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

  -- resizing the master/slave ratio
  , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
  , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area

  -- floating layer support
  -- , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

  -- increase or decrease number of windows in the master area
  , ((modMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
  , ((modMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

  -- quit, or restart
  , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
  , ((modMask              , xK_q     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad

  -- screenshot
  , ((modMask .|. shiftMask, xK_4), captureWorkspacesWhen defaultPredicate defaultHook horizontally)

  -- , ((modMask .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -")) -- %! Run xmessage with a summary of the default keybindings (useful for beginners)
  -- repeat the binding for non-American layout keyboards
  -- , ((modMask              , xK_question), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
  ]
  ++
  -- mod-[1..9] %! Switch to workspace N
  -- mod-shift-[1..9] %! Move client to workspace N
  [((m .|. controlMask, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  -- ++
  -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
  -- [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
  --   | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
  --   , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

startup = do
  spawn "feh --bg-fill ~/.background.jpg"
