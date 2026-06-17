{ self, inputs, ... }: {
  flake.nixosModules.minimalHardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:

    {
      imports = [
        self.nixosModules.hardwareCommon
      ];
    };
}
