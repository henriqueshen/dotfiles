{ self, inputs, ... }: {
  flake.nixosModules.minimalDisk =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.diskCommon

        self.diskoConfiguration.minimal
      ];
    };

  flake.diskoConfiguration.minimal = {
    disko.devices.disk = {
      main = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0077"
                  "dmask=0077"
                ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
