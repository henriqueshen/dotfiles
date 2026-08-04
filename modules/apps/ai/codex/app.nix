{ self, inputs, ... }: {
  flake.homeModules.codex =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
      ];

      home.file.".codex/AGENTS.md" = {
        source = ./AGENTS.md;
        force = true;
      };
      home.activation.linkCodexSettings = lib.mkAfter ''
        $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.codex"
        $DRY_RUN_CMD ln -sfn \
          "${config.home.homeDirectory}/dotfiles/modules/apps/ai/codex/config.toml" \
          "${config.home.homeDirectory}/.codex/config.toml"
      '';

      programs.codex = {
        enable = true;
      };
    };
}
