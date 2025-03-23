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
          "docker"
          "firefox@developer-edition"
          "ghostty"
          "google-drive"
          "kicad"
          "microsoft-teams"
          "roon"
          "sequel-ace"
          "thunderbird"
          # Not installed
          # -------------
          # "azure-data-studio"
          # "beekeeper-studio"
        ];
      };
      environment.etc."sudoers.d/jps".text = ''
        jps ALL=(ALL) NOPASSWD:ALL
      '';
      environment.systemPackages = [
        pkgs.helix
      ];
      security.pam.enableSudoTouchIdAuth = true;
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";
      nixpkgs.config = { allowUnfree = true; };

      system.keyboard = {
        enableKeyMapping = true;
        remapCapsLockToControl = true;
      };
      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "Nlsv";  # Nlsv (list), clmv (column), Flwv (cover flow)
        loginwindow.LoginwindowText = "Lamport";
        screencapture.location = "~/Downloads";
        screensaver.askForPasswordDelay = 30;
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

      #nix.enable = false;
      nix.settings.experimental-features = "nix-command flakes";
      #nix.settings.extra-nix-path = "nixpkgs=flake:nixpkgs";
      # nix.configureBuildUsers = true;

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
