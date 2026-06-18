{ self, inputs, ... }: {
  flake.homeModules.git =
    { config, pkgs, ... }:
    {
      imports = [
        self.homeModules.secretsCommon
      ];

      sops.secrets."/git/ssh-key" = {
      };

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = {
          "github.com" = {
            HostName = "github.com";
            IdentityFile = config.sops.secrets."git/ssh-key".path;
          };
        };
      };

    };
}
