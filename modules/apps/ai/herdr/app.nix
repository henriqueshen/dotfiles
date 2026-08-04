{ self, inputs, ... }: {
  flake.homeModules.herdr =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      programs.herdr = {
        enable = true;
      };
    };
}
