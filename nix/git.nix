{
  programs.git.enable = true;
  xdg.configFile = {
    "git/config".source = ../common/git/gitconfig;
    "git/ignore".source = ../common/git/gitignore-global;
  };
}
