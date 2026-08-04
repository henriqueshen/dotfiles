{ self, inputs, ... }: {
  flake.homeModules.discord =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.packages = with pkgs; [
        discord
      ];
    };
}
