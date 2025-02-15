{
  description = "JP's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nix-darwin, nixpkgs, home-manager }:
  let
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
          # "azure-data-studio"
          "alt-tab"
          "docker"
          "firefox@developer-edition"
          "ghostty"
          "google-drive"
          "kicad"
          "microsoft-teams"
          "openscad"
          "roon"
          # "beekeeper-studio"
          "sequel-ace"
          # "steam"
          "thunderbird"
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
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config = { allowUnfree = true; };

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        # Options are: Nlsv (list), clmv (column), Flwv (cover flow)
        finder.FXPreferredViewStyle = "Nlsv";
        loginwindow.LoginwindowText = "Shamir";
        screencapture.location = "~/Downloads";
        screensaver.askForPasswordDelay = 30;
        LaunchServices.LSQuarantine = false;
        NSGlobalDomain = {
          NSAutomaticSpellingCorrectionEnabled = false;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
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
          # { enabled = 0; name = "CALCULATOR"; }  # breaks the window
          # { enabled = 0; name = "MENU_CALCULATOR"; }  # breaks the window
        ];
      };

      nix.enable = false;
      nix.settings.experimental-features = "nix-command flakes";
      # nix.configureBuildUsers = true;
      nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';

      fonts = {
        packages = with pkgs; [
          meslo-lgs-nf
        ];
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#shamir
    darwinConfigurations."shamir" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        home-manager.darwinModules.home-manager
        {
          users.users.jps.home = "/Users/jps";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jps = import ./users/jps/home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."shamir".pkgs;
  };
}
