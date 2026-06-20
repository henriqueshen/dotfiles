{ self, inputs, ... }:
{
  flake.nixvimModules.gitsigns = { pkgs, lib, ... }: {
    plugins.gitsigns = {
      enable = true;
    };
  };
}
