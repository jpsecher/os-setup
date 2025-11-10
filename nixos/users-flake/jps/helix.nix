{ ... }:
{
  programs.helix = {
    enable = true;
    # package = nixpkgs-unstable.helix;
  };
  xdg.configFile."helix/config.toml".source = ../../../common/helix/config.toml;
  xdg.configFile."helix/languages.toml".source = ../../../common/helix/languages.toml;
}
