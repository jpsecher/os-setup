{
  programs.helix = {
    enable = true;
    # defaultEditor = true;
  };
  xdg.configFile."helix/config.toml".source = ../../../common/helix/config.toml;
}
