{ pkgs, username, ... }:
{
  imports = [
  #   ./chromium.nix
  #   ./dunst.nix
  #   ./git.nix
    ./helix.nix
  #   ./sway.nix
  #   ./tmux.nix
  #   ./zsh.nix
  ];
  # xdg.enable = true;
  # fonts.fontconfig.enable = true;
  home = {
    stateVersion = "25.05";  # Don't change
    username = username;
    homeDirectory = "/home/${username}";
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
      lazygit
    ];
  };
}
