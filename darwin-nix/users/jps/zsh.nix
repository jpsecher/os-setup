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
    history.ignoreAllDups = true;
    shellAliases = {
      glances = "glances --disable-bg";
      dockernodels = "docker node ls -q | xargs docker node inspect -f '\''{{ .Description.Hostname }} [{{ .ID }}]: {{ range $k, $v := .Spec.Labels }}{{ $k }}={{ $v }} {{end}}'\''";
      dockerps = "docker ps --format '\''table {{ .Status }}\t{{ .ID }}\t{{ .Names }}\t{{ .Ports }}'\''";
      dockerservicels = "docker service ls --format 'table {{ .Name }}\t{{ .Mode }}\t{{ .Replicas }}\t{{ .Ports }}'";
      dockerstackps = "docker stack ps --format '\''table {{ .Name }}\t{{ .Node }}\t{{ .DesiredState }}\t{{ .CurrentState }}\t{{ .Ports }}\t{{ .Error }}'\'' --filter '\''desired-state=running'\''";
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
