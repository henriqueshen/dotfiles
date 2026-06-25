{ self, inputs, ... }: {
  flake.homeModules.pi =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.packages = with pkgs; [
        pi-coding-agent
      ];
    };
}
