{ self, inputs, ... }: {
  flake.nixosModules.laptopConfiguration =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.hostsCommon

        self.nixosModules.laptopHardware

        self.nixosModules.hshen2908

        self.nixosModules.niri2
      ];

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        initrd.availableKernelModules = [
          "usbhid"
          "xhci_pci"
          "nvme"
          "usb_storage"
          "sd_mod"
        ];
      };

      programs.niri.customSettings = {
        settings = {
          outputs = {
            "eDP-1" = {
              mode = "2880x1800@60";
              position = _: {
                props = {
                  x = 0;
                  y = 0;
                };
              };
              transform = "180";
            };
            "eDP-2" = {
              mode = "2880x1800@60";
              position = _: {
                props = {
                  x = 0;
                  y = 1029;
                };
              };
            };
          };
        };
      };

      networking.hostName = "rnixos";

      networking.networkmanager.enable = true;

      time.timeZone = "America/Sao_Paulo";

      i18n.defaultLocale = "en_US.UTF-8";

      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Experimental = true;
            FastConnectable = true;
          };
          Policy = {
            AutoEnable = true;
          };
        };
      };

      programs.mtr.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      services.openssh.enable = true;

      system.stateVersion = "26.05";

    };
}
