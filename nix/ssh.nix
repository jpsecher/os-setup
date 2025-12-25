{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "i-*" = {
        user = "ubuntu";
        proxyCommand = "sh -c \"aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
        identityFile = [
          "~/.ssh/dnp-devops-production-ed25519"
          "~/.ssh/dnp-devops-staging-ed25519"
          "~/.ssh/customerportal-devops-production-ed25519"
        ];
      };
    };
  };
}
#Host *
#  ForwardAgent no
#  AddKeysToAgent no
#  Compression no
#  ServerAliveInterval 0
#  ServerAliveCountMax 3
#  HashKnownHosts no
#  UserKnownHostsFile ~/.ssh/known_hosts
#  ControlMaster no
#  ControlPath ~/.ssh/master-%r@%n:%p
#  ControlPersist no
