import XMonad
import XMonad.Hooks.DynamicLog

main :: IO ()
main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig

myConfig = def
  { terminal = "alacritty"
  }

myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "[" "]" }

-- Toggle visibility of xmobar with A-k
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
