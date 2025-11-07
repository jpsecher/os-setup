{ pkgs, ... }:
{
  # imports = [
  #   ./alacritty.nix
  #   ./chromium.nix
  #   ./dunst.nix
  #   ./git.nix
  #   ./helix.nix
  #   ./sway.nix
  #   ./tmux.nix
  #   ./zsh.nix
  # ];
  # xdg.enable = true;
  # fonts.fontconfig.enable = true;
  home = {
    stateVersion = "25.05";
    username = "jps";
    homeDirectory = "/home/jps";
    sessionVariables = {
      EDITOR = "hx";
    };
    packages = with pkgs; [
      dig
      doggo  # dig alternative
      duf  # du alternative
      fd  # find alternative
      glances
      glow  # markdown render
      jq
      jqp  # TUI for interactive jq
      just  # Make alternative
      neofetch
    ];
  };
}
