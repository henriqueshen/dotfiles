{ self, inputs, ... }: {
  flake.homeModules.herdr =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      programs.herdr = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr;
      };
    };
}
