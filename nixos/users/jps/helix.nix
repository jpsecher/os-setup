{ unstable, ... }:
{
  programs.helix = {
    enable = true;
    package = unstable.helix;
  };
  xdg.configFile."helix/config.toml".source = ../../../common/helix/config.toml;
}
