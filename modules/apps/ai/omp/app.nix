{ self, inputs, ... }:
{
  flake.homeModules.omp =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home.file.".omp/agent/AGENTS.md" = {
        source = ../AGENTS.md;
        force = true;
      };
      home.file.".omp/agent/themes/cyberdream.json" = {
        source = ./themes/cyberdream.json;
        force = true;
      };
      home.activation.linkOmpConfig = lib.mkAfter ''
        $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.omp/agent"
        $DRY_RUN_CMD ln -sfn \
          "${config.home.homeDirectory}/dotfiles/modules/apps/ai/omp/config.yml" \
          "${config.home.homeDirectory}/.omp/agent/config.yml"
      '';

      home.packages = [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.omp
      ];
    };
}
