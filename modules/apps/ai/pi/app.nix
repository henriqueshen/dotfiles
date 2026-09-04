{ self, inputs, ... }: {
  flake.homeModules.pi =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
      ];

      home.file.".pi/agent/skills/herdr/SKILL.md" = {
        source = ../herdr/SKILL.md;
        force = true;
      };
      home.file.".pi/agent/themes/cyberdream.json" = {
        source = ./themes/cyberdream.json;
        force = true;
      };
      home.activation.linkPiSettings = lib.mkAfter ''
        $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.pi/agent"
        $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.config/mcp"
        $DRY_RUN_CMD ln -sfn \
          "${config.home.homeDirectory}/dotfiles/modules/apps/ai/pi/settings.json" \
          "${config.home.homeDirectory}/.pi/agent/settings.json"
        $DRY_RUN_CMD ln -sfn \
          "${config.home.homeDirectory}/dotfiles/modules/apps/ai/pi/mcp.json" \
          "${config.home.homeDirectory}/.config/mcp/mcp.json"
      '';

      home.packages = [
        pkgs.nodejs_latest
        (pkgs.symlinkJoin {
          name = "pi-coding-agent";
          buildInputs = [ pkgs.makeWrapper ];
          paths = [
            inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi
          ];
          postBuild = ''
            wrapProgram $out/bin/pi \
              --set NPM_CONFIG_PREFIX ${config.home.homeDirectory}/.pi/npm/ \
              --prefix PATH : ${
                pkgs.lib.makeBinPath [
                  pkgs.nodejs_latest
                ]
              }
          '';
        })
      ];
    };
}
