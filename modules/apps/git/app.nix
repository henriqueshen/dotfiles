{ self, inputs, ... }: {
  flake.homeModules.git =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      programs.git = {
        enable = true;
      };

      programs.gh = {
        enable = true;
        gitCredentialHelper = {
          enable = true;
        };
      };
    };
}
