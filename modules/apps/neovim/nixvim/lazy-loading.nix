{ self, inputs, ... }:
{
  flake.nixvimModules.lazy-loading = { pkgs, lib, ... }: {
    plugins.lz-n = {
      enable = true;
    };
  };
}
