{ self, inputs, ... }: {
  flake.homeModules.herdr =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.packages = with pkgs; [
        herdr
      ];
    };
}
