{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
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
    # if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
    #   [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    # else
    #   [[ ! -f ~/.p10k-portable.zsh ]] || source ~/.p10k-portable.zsh
    # fi
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
