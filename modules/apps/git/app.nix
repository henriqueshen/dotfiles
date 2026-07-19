{ self, inputs, ... }: {
  flake.homeModules.git =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      programs.git = {
        enable = true;
      };

      home.packages = with pkgs; [
        gh
      ];
    };
}
