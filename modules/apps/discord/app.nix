{ self, inputs, ... }: {
  flake.homeModules.disord =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.packages = with pkgs; [
        discord
      ];
    };
}
