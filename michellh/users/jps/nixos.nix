{ pkgs, inputs, ... }:

{
  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  programs.zsh.enable = true;

  users.users.jps = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/jps";
    extraGroups = [ "docker" "wheel" ];
    # Made with mkpasswd
    hashedPassword = "$y$j9T$Fomy8cZc7dFXS0g8MlIvx1$dqf7kCeK6JOi5T1r97j/zwE8voLEQlcJ5HNmUxgK9IB";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5qxXZ2cdgdcrNVCT+rbLiSN+dRPnwjDYt/wZHGwcbBPxqJ/dXeHZOPJ/Ue8blApsVoUj6t7J3FFOwnUllDopgNSQKsQ2UrOQd7NbPHKFMaA/dYsTQZWNCB3AwNSqV0CP0aXytm0XCiN5ATCsroPbfGfLQI45e3+/Cu96SN/JFFZn/jCbgZSFpckIwGYlBvQHfY8e4hbDK9KR80BQlfx4BEtyPil8HxymNDvKKLTNidTQ2qTHkKs2rBd4oY51AIcmsg7EBdO4Tqbh4vKjemZHh7XL8+T5tRCIfXiyzModHXA3orlq4Dg2UnRSUITfcX7EayUgf3midjQI4Dv/PiLEL jps"
    ];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix;
}
