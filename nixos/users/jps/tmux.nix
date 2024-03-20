{
  programs.tmux = {
    enable = true;
    plugins = [];
  };
  xdg.configFile."tmux/tmux.conf".source = ../../../common/tmux/tmux.conf;
}
