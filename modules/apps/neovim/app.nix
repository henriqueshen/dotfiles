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
      config,
      self',
      pkgs,
      system,
      ...
    }:
    {

      nixvimConfigurations = {
        ide = inputs.nixvim.lib.evalNixvim {
          inherit system;

          modules = [
            self.nixvimModules.keymaps
            self.nixvimModules.options

            {
              plugins.telescope.enable = true;
            }
          ];
        };
      };

      packages.nixvim = config.nixvimConfigurations.ide.config.build.package;
    };
}
