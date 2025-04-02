{
  description = "JP's nix-darwin system flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, nixpkgs, nixpkgs-unstable, home-manager }:
  let
    system = "x86_64-darwin";
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    configuration = { pkgs, config, ... }: {
      homebrew = {
        enable = true;
        onActivation = {
          # Set temporarily to true to get new casks
          # After which you need to `sudo rm -rf ~/Applications/Nix\ Trampolines`
          autoUpdate = false;
          upgrade = false;
          # Remove all unmanaged packages
          cleanup = "zap";
        };
        global = {
          brewfile = true;
          lockfiles = true;
        };
        taps = [];
        brews = [];
        casks = [
          "alt-tab"
          "claude"
          "docker"
          "firefox@developer-edition"
          "ghostty"
          "google-drive"
          "kicad"
          "microsoft-teams"
          "roon"
          "sequel-ace"
          "thunderbird"
          "vlc"
          # Not installed
          # -------------
          # "azure-data-studio"
          # "beekeeper-studio"
        ];
      };
      environment = {
        etc."sudoers.d/jps".text = ''
          jps ALL=(ALL) NOPASSWD:ALL
        '';
        systemPackages = [pkgs.helix];
        # TODO: figure out how to use (user)LaunchAgents and (user)LaunchDaemons
      };
      security.pam.enableSudoTouchIdAuth = true;

      nixpkgs = {
        hostPlatform = "x86_64-darwin";
        config = { allowUnfree = true; };
      };

      networking = {
        computerName = "Lamport";
        hostName = "lamport";
      };

      # programs.info.enable = false;
      time.timeZone = "Europe/Copenhagen";
      system = {
        stateVersion = 5;
        # Set Git commit hash for darwin-version.
        configurationRevision = self.rev or self.dirtyRev or null;
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
      
      nix.settings.experimental-features = "nix-command flakes";

      fonts = {
        packages = with pkgs; [
          meslo-lgs-nf
        ];
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#lamport
    darwinConfigurations."lamport" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration 
        home-manager.darwinModules.home-manager
        {
          users.users.jps.home = "/Users/jps";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jps = { ... }: {
            imports = [ ../../users/jps/home.nix ];
            _module.args.pkgs-unstable = pkgs-unstable;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."lamport".pkgs;
  };
}
