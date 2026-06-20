{ self, inputs, ... }:
{
  flake.nixvimModules.nvim-bqf = { pkgs, lib, ... }: {
    plugins.nvim-bqf = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings.ft = "qf";
      };
    };
  };
}
