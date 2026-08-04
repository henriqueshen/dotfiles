{ self, inputs, ... }: {
  flake.nixosModules.laptopHardware =
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

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/0bad0e65-b905-440d-abf7-4bdeea8e3a4b";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/6692-9B96";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [ ];

      hardware.cpu.intel.npu.enable = true;
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
