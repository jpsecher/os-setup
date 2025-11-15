{ pkgs, ... }:
{
  home.packages = with pkgs; [
    awscli2  # Amazon Web Services
    ssm-session-manager-plugin  # AWS SSM CLI
  ];
}
