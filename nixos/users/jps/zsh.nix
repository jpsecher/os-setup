{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    # oh-my-zsh = {
      # enable = true;
      # plugins = ["git" "docker" "git-extras" "aws"];
      # plugins = [git docker git-extras ansible pip python ssh-agent];
      # custom = "$HOME/repos/personal/os-setup/common/zsh";
      # theme = "jpsecher";
      # theme = "fino-time";
      #theme = "robbyrussell";
      #theme = "agnoster";
    # };
    plugins = [ {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      } {
        name = "powerlevel10k-config";
        src = ../../../common/zsh;
        file = "p10k.zsh";
      }
    ];
    initExtra = "";
    loginExtra = ''
      google-drive-ocamlfuse -label personal ~/gdrive-personal
    '';
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
