{ self, inputs, ... }: {
  flake.homeModules.claude-code =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.file.".claude/CLAUDE.md" = {
        source = ./CLAUDE.md;
        force = true;
      };
      home.file.".claude/settings.json" = {
        source = ./settings.json;
        force = true;
      };
      home.file.".claude/skills/herdr/SKILL.md" = {
        source = ../herdr/SKILL.md;
        force = true;
      };

      programs.claude-code = {
        enable = true;
        mcpServers.linear-server = {
          type = "http";
          url = "https://mcp.linear.app/mcp";
        };
      };
    };
}
