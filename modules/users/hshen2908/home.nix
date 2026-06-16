{
  self,
  config,
  inputs,
  ...
}:
{
  perSystem = { pkgs, system, ... }: {
    legacyPackages.homeConfigurations."hshen2908" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        self.homeModules.hshen2908
      ];
    };
  };
  flake.homeModules.hshen2908 =
    { config, pkgs, ... }:
    {
      imports = [
        self.homeModules.usersCommon
      ];

      home = {
        username = "hshen2908";
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/hshen2908" else "/home/hshen2908";
        stateVersion = "26.05";
      };

      # myHomeModules.apps.neovim.enable = true;
      # myHomeModules.apps.tmux.enable = false;
      programs.git = {
        enable = true;
        settings.user = {
          name = "Henrique Shen";
          email = "dev.henrique.shen@gmail.com";
        };
      };

      services.kanshi = {
        enable = true;
        systemdTarget = "graphical-session.target";
        settings = [
          {
            profiles = {
              name = "default";
              outputs = [
                {
                  criteria = "eDP-1";
                  mode = "2880x1800@60";
                  position = "0,0";
                  transform = "180";
                }
                {
                  criteria = "eDP-2";
                  mode = "2880x1800@60";
                  position = "0,1800";
                }
              ];
            };
          }
        ];
      };

      home.packages = with pkgs; [
        vscode
        firefox
      ];
    };
}
