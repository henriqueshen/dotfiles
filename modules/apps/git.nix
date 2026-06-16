{ self, inputs, ... }: {
  flake.homeModules.git =
    { config, pkgs, ... }:
    {
      programs.git = {
        enable = true;
      };
    };
}
