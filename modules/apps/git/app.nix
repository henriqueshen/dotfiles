{ self, inputs, ... }: {
  flake.homeModules.git =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      programs.git = {
        enable = true;
      };
    };
}
