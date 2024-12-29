{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "i-*" = {
        user = "ubuntu";
        proxyCommand = "sh -c \"aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
        identityFile = [
          "~/.ssh/dnp-devops-production-ed25519"
          "~/.ssh/dnp-devops-staging-ed25519"
        ];
      };
    };
  };
}
