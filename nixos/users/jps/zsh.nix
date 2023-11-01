{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [];
      theme = "robbyrussell";
      #theme = "agnoster";
    };
    initExtra = "";
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
