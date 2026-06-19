{ self, inputs, ... }:
{
  flake.nixvimModules.colorscheme = { pkgs, lib, ... }: {
    colorschemes.cyberdream = {
      enable = true;
      settings = {
        transparent = true;
      };
    };
  };
}
