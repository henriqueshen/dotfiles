{ self, inputs, ... }:
{
  nixvim = {
    checks.enable = true;
    packages.enable = true;
  };

  flake.nixosModules.neovim =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim
      ];
    };

  flake.homeModules.neovim =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      home.packages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim
      ];
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      system,
      ...
    }:
    {
      perSystem =
        {
          config,
          self',
          pkgs,
          system,
          ...
        }:
        {

          nixvimConfigurations = {
            ide = {
              imports = [
                self'.flake.nixvimModules.keymaps
                self'.flake.nixvimModules.options
              ];

              plugins.telescope.enable = true;
            };

            minimal = {
              imports = [
                self'.flake.nixvimModules.keymaps
                self'.flake.nixvimModules.options
              ];

              colorschemes.nord.enable = true;
            };
          };

          packages.nixvim = config.nixvimConfigurations.ide.wrapped;
          packages.nixvimMinimal = config.nixvimConfigurations.minimal.wrapped;
        };
    };
}
