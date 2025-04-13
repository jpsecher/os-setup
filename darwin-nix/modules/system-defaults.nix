{ config, lib, pkgs, ... }:
{
  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/Applications/Ghostty.app"
          "/System/Applications/System Settings.app"
        ];
      };
      finder = {
        AppleShowAllExtensions = true;
        CreateDesktop = false;
        FXPreferredViewStyle = "Nlsv";  # Nlsv (list), clmv (column), Flwv (cover flow)
        FXDefaultSearchScope = "SCcf";  # Search current folder
        FXEnableExtensionChangeWarning = false;
        NewWindowTarget = "Home";
        ShowMountedServersOnDesktop = true;
        ShowPathbar = true;
      };
      menuExtraClock = {
        Show24Hour = true;
        ShowDate = 0;  # When space allows
        ShowDayOfWeek = true;
      };
      loginwindow.LoginwindowText = "Lamport";
      screencapture.location = "~/Downloads";
      screensaver.askForPasswordDelay = 30;
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerTapGesture = 0;
        TrackpadThreeFingerDrag = true;
      };
      # universalaccess.reduceMotion = true;
      # universalaccess.reduceTransparency = true;
      LaunchServices.LSQuarantine = false;
      NSGlobalDomain = {
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        AppleEnableMouseSwipeNavigateWithScrolls = false;
        AppleEnableSwipeNavigateWithScrolls = false;
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        AppleScrollerPagingBehavior = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        "com.apple.keyboard.fnState" = true;
        "com.apple.mouse.tapBehavior" = 1;
        _HIHideMenuBar = true;
      };
      CustomUserPreferences."com.apple.Spotlight"."orderedItems" = [
        { enabled = 1; name = "APPLICATIONS"; }
        { enabled = 1; name = "MENU_EXPRESSION"; }
        { enabled = 1; name = "DIRECTORIES"; }
        { enabled = 1; name = "SYSTEM_PREFS"; }
        { enabled = 0; name = "MENU_CONVERSION"; }
        { enabled = 0; name = "MENU_DEFINITION"; }
        { enabled = 0; name = "SOURCE"; }
        { enabled = 0; name = "DOCUMENTS"; }
        { enabled = 0; name = "EVENT_TODO"; }
        { enabled = 0; name = "FONTS"; }
        { enabled = 0; name = "IMAGES"; }
        { enabled = 0; name = "MESSAGES"; }
        { enabled = 0; name = "MOVIES"; }
        { enabled = 0; name = "MUSIC"; }
        { enabled = 0; name = "MENU_OTHER"; }
        { enabled = 0; name = "PDF"; }
        { enabled = 0; name = "PRESENTATIONS"; }
        { enabled = 0; name = "MENU_SPOTLIGHT_SUGGESTIONS"; }
        { enabled = 0; name = "SPREADSHEETS"; }
        { enabled = 0; name = "TIPS"; }
        { enabled = 0; name = "BOOKMARKS"; }
        # { enabled = 0; name = "CONTACTS"; }  # breaks the window
        # { enabled = 0; name = "CALCULATOR"; }  # breaks the window
        # { enabled = 0; name = "MENU_CALCULATOR"; }  # breaks the window
      ];
    };
  };
}
