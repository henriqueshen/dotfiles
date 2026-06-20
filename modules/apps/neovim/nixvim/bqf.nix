{ self, inputs, ... }:
{
  flake.nixvimModules.bqf = { pkgs, lib, ... }: {
    plugins.bqf = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings.ft = "qf";
      };
    };
  };
}
