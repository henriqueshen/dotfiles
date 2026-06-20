{ self, inputs, ... }:
{
  flake.nixvimModules.keymaps = { pkgs, lib, ... }: {
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };
  };
}
