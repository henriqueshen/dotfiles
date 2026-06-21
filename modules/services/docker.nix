{ self, inputs, ... }: {
  flake.nixosModules.docker =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      virtualisation.docker = {
        enable = true;
      };
    };
}
