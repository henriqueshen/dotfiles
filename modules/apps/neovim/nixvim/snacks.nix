{ self, inputs, ... }:
{
  flake.nixvimModules.snacks = { pkgs, lib, ... }: {
    plugins.snacks = {
      enable = true;
    };
  };
}
