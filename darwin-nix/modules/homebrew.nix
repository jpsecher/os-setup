{ config, lib, pkgs, ... }:
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
        "docker"
        "claude"
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
      ] ++ config.local.homebrew.extraCasks;
    };
  };
}
