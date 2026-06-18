{ self, inputs, ... }: {
  flake.homeModules.git =
    { config, pkgs, ... }:
    {
      imports = [
        self.homeModules.secretsCommon
      ];

      sops.secrets.git_ssh_key = {
      };

      programs.ssh = {
        enable = true;
        matchBlocks = {
          "github.com" = {
            identityFile = config.sops.secrets."/git/ssh-key".path;
          };
        };
      };

    };
}
