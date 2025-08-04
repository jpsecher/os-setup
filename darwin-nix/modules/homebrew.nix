{ config, lib, ... }:
{
  options = {
    local.homebrew.extraCasks = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional Homebrew casks to install";
    };
  };
  config = {
    homebrew = {
      enable = true;
      onActivation = {
        # Set temporarily to true to get new casks
        # After which you need to `sudo rm -rf ~/Applications/Nix\ Trampolines`
        autoUpdate = false;
        upgrade = false;
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
        "freecad"
        "ghostty"
        "google-drive"
        "inkscape"
        "homerow"
        "kicad"
        "roon"
        "prusaslicer"
        "signal"
        "thunderbird"
        "vlc"
        # Not installed
        # -------------
        # "azure-data-studio"
        # "beekeeper-studio"
        # "the-unarchiver"
      ] ++ config.local.homebrew.extraCasks;
    };
  };
}
