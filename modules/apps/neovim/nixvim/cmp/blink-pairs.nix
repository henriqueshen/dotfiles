{ self, inputs, ... }:
{
  flake.nixvimModules.blink-pairs = { pkgs, lib, ... }: {
    plugins.blink-pairs = {
      enable = true;
    };
  };
}
