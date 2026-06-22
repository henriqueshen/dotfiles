{ self, inputs, ... }: {
  flake.homeModules.doppler =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.packages = [
        pkgs.doppler
      ];
    };
}
