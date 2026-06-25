{
  self,
  config,
  inputs,
  ...
}:
{
  flake.nixosModules.hshen2908Home =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.homeCommon
      ];
      home-manager = {
        users."hshen2908" = self.homeModules.hshen2908;
      };
    };
  flake.homeModules.hshen2908 =
    { config, pkgs, ... }:
    {
      imports = [
        self.homeModules.homeCommon

        self.homeModules.zsh
        self.homeModules.git
        self.homeModules.tmux
        self.homeModules.neovim
        self.homeModules.doppler
        self.homeModules.pi

        self.homeModules.discord
      ];

      home = {
        username = "hshen2908";
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/hshen2908" else "/home/hshen2908";
        stateVersion = "26.05";
      };

      programs.git = {
        settings.user = {
          name = "Henrique Shen";
          email = "dev.henrique.shen@gmail.com";
        };
      };

      home.packages = with pkgs; [
        vscode
        firefox
      ];
    };
  perSystem = { pkgs, system, ... }: {
    legacyPackages.homeConfigurations."hshen2908" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        self.homeModules.hshen2908
      ];
    };
  };
}
