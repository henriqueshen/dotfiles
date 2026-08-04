{ self, inputs, ... }: {
  flake.homeModules.claude-code =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
      ];

      home.file.".claude/CLAUDE.md" = {
        source = ./CLAUDE.md;
        force = true;
      };
      home.file.".claude/statusline.sh" = {
        source = ./statusline.sh;
        force = true;
      };
      home.file.".claude/skills/herdr/SKILL.md" = {
        source = ../herdr/SKILL.md;
        force = true;
      };
      home.file.".claude.1/CLAUDE.md" = {
        source = ./CLAUDE.md;
        force = true;
      };
      home.file.".claude.1/statusline.sh" = {
        source = ./statusline.sh;
        force = true;
      };
      home.file.".claude.1/skills/herdr/SKILL.md" = {
        source = ../herdr/SKILL.md;
        force = true;
      };
      home.activation.linkClaudeSettings = lib.mkAfter ''
        $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.claude"
        $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.claude.1"
        $DRY_RUN_CMD ln -sfn \
          "${config.home.homeDirectory}/dotfiles/modules/apps/ai/claude-code/settings.json" \
          "${config.home.homeDirectory}/.claude/settings.json"
        $DRY_RUN_CMD ln -sfn \
          "${config.home.homeDirectory}/dotfiles/modules/apps/ai/claude-code/settings.json" \
          "${config.home.homeDirectory}/.claude.1/settings.json"
      '';

      home.packages = with pkgs; [
        nodejs
        python3
        jq
      ];

      programs.claude-code = {
        enable = true;
      };
    };
}
