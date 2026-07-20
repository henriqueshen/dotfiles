{ self, inputs, ... }: {
  flake.homeModules.claude-code =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.file.".claude/CLAUDE.md".source = ./CLAUDE.md;

      programs.claude-code = {
        enable = true;
        settings = {
          model = "claude-fable-5[1m]";
          theme = "dark";
          agentPushNotifEnabled = true;

          enabledPlugins = {
            "rust-analyzer-lsp@claude-plugins-official" = true;
            "superpowers@claude-plugins-official" = true;
            "codex@openai-codex" = true;
            "code-simplifier@claude-plugins-official" = true;
            "frontend-design@claude-plugins-official" = true;
            "context7@claude-plugins-official" = true;
            "code-review@claude-plugins-official" = true;
            "feature-dev@claude-plugins-official" = true;
            "mattpocock-skills@mattpocock" = true;
          };

          extraKnownMarketplaces = {
            openai-codex.source = {
              source = "github";
              repo = "openai/codex-plugin-cc";
            };
            mattpocock.source = {
              source = "github";
              repo = "mattpocock/skills";
            };
          };
        };

        mcpServers.linear-server = {
          type = "http";
          url = "https://mcp.linear.app/mcp";
        };
      };
    };
}
