{ self, inputs, ... }: {
  flake.homeModules.orca =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.packages = [
        pkgs.xvfb
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.orca
      ];
    };
}
