{ self, inputs, ... }:
{
  flake.nixvimModules.theme = { pkgs, lib, ... }: {
    colorschemes.cyberdream.enable = true;
  };
}
