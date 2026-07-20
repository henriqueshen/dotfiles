{ self, inputs, ... }: {
  flake.homeModules.codex =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      programs.codex = {
        enable = true;
      };
    };
}
