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
        # Set temporarily to true to get new casks and run
        # `sudo rm -rf ~/Applications/Nix\ Trampolines`
        # before.
        autoUpdate = false;
        upgrade = false;
        cleanup = "zap";
      };
      global = {
        brewfile = true;
        lockfiles = true;
      };
      taps = [];
      brews = [
        # "codecrafters-io/homebrew-tap/codecrafters"
        "gurk"  # Signal TUI
      ];
      masApps = {};
      # greedyCasks = true;
      # ^^^ does not exists, so you need to uninstall an reinstall certain casks, like google-drive.
      casks = [
        "alt-tab"
        "claude"
        "firefox"
        "ghostty"
        "google-drive"
        "inkscape"
        "signal"
        "thunderbird"
        "vlc"
        # Not installed
        # -------------
        # "azure-data-studio"
        # "beekeeper-studio"
        # "homerow"
        # "the-unarchiver"
      ] ++ config.local.homebrew.extraCasks;
    };
  };
}
