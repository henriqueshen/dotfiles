{ self, inputs, ... }: {
  flake.homeModules.orca =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      programs.orca = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.orca;
      };
    };
}
