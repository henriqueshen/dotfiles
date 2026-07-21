{ self, inputs, ... }:
{
  flake.nixvimModules.markview = { pkgs, lib, ... }: {
    plugins.markview = {
      enable = true;
    };
  };
}
