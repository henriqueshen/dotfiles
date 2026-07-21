{ self, inputs, ... }: {
  flake.homeModules.codex =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.file.".codex/AGENTS.md" = {
        source = ./AGENTS.md;
        force = true;
      };

      programs.codex = {
        enable = true;
      };
    };
}
