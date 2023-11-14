{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "docker" "git-extras"];
      # plugins = [git docker git-extras ansible pip python ssh-agent];
      theme = "fino-time";
      #theme = "robbyrussell";
      #theme = "agnoster";
    };
    initExtra = "";
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
