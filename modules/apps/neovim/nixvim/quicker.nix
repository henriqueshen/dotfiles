{ self, inputs, ... }:
{
  flake.nixvimModules.quicker = { pkgs, lib, ... }: {
    plugins.quicker = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings.ft = "qf";
      };
    };

    keymaps = [
      {
        key = "<leader>qq";
        action = lib.nixvim.mkRaw "function() require('quicker').toggle({ focus = true }) end";
        options = {
          desc = "Toggle Quickfix";
          silent = true;
        };
      }
      {
        key = "<leader>ql";
        action = lib.nixvim.mkRaw "function() require('quicker').toggle({ focus = true, loclist = true }) end";
        options = {
          desc = "Toggle Location List";
          silent = true;
        };
      }
    ];
  };
}
