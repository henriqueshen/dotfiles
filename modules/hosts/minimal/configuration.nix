{ self, inputs, ... }: {
  flake.nixosModules.minimalConfiguration =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.configurationCommon

        self.nixosModules.minimalHardware

        self.nixosModules.hshen2908
      ];

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
      };

      networking.hostName = "nixos";

      networking.networkmanager.enable = true;

      time.timeZone = "America/Sao_Paulo";

      i18n.defaultLocale = "en_US.UTF-8";

      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      services.openssh.enable = true;

      system.stateVersion = "26.05";

    };
}
