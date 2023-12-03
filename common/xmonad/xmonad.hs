import XMonad
import XMonad.Hooks.DynamicLog

main :: IO ()
main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig

myConfig = def
  { terminal = "alacritty"
  , modMask = mod4Mask -- Use Super as Modifier key
  }

myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "[" "]" }

-- Toggle visibility of xmobar with M-b
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
