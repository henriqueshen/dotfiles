{ self, inputs, ... }: {
  flake.homeModules.codex =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.packages = with pkgs; [
        codex
      ];
    };
}
