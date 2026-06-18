{ self, inputs, ... }: {
  flake.homeModules.git =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      programs.git = {
        enable = true;
        startAgent = true;
        extraConfig = ''
          AddKeysToAgent yes
        '';
        settings.user = {
          name = "Henrique Shen";
          email = "dev.henrique.shen@gmail.com";
        };
      };

      services.ssh-agent.enable = true;
      programs.ssh = {
        enable = true;
        matchBlocks = {
          "*" = {
            addKeysToAgent = "yes";
          };
        };
      };
    };
}
