{ self, inputs, ... }: {
  flake.nixosModules.diskCommon =
    { config, pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.disko
      ];
    };
}
