{ pkgs, ... }:
let
  configThemeNormal = ../../../common/zsh/p10k.zsh;
  configThemeTty = ../../../common/zsh/p10k-portable.zsh;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      glances = "glances --disable-bg";
    };
    plugins = [ {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtra = ''
      # See https://github.com/NixOS/nixpkgs/issues/154696#issuecomment-1238433989
      if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
        [[ ! -f ${configThemeNormal} ]] || source ${configThemeNormal}
      else
        [[ ! -f ${configThemeTty} ]] || source ${configThemeTty}
      fi
    '';
    loginExtra = ''
      google-drive-ocamlfuse -label personal ~/gdrive-personal
      sway
    '';
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
 };
}
