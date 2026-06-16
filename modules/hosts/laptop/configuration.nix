{ self, inputs, ... }: {
  flake.nixosModules.laptopConfiguration =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.hostsCommon

        self.nixosModules.laptopHardware

        self.nixosModules.hshen2908

        self.nixosModules.niri
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

      networking.hostName = "nixos";

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
