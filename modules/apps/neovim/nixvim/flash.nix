{ self, inputs, ... }:
{
  flake.nixvimModules.flash =
    {
      pkgs,
      lib,
      ...
    }:
    {
      plugins.flash = {
        enable = true;
      };
      keymaps = [
        {
          key = "s";
          mode = [
            "n"
            "x"
            "o"
          ];
          action = lib.nixvim.mkRaw "function() require('flash').jump() end";
          options = {
            desc = "Flash";
            silent = true;
          };
        }
        {
          key = "S";
          mode = [
            "n"
            "x"
            "o"
          ];
          action = lib.nixvim.mkRaw "function() require('flash').treesitter() end";
          options = {
            desc = "Flash Treesitter";
            silent = true;
          };
        }
        {
          key = "r";
          mode = "o";
          action = lib.nixvim.mkRaw "function() require('flash').remote() end";
          options = {
            desc = "Remote Flash";
            silent = true;
          };
        }
        {
          key = "R";
          mode = [
            "o"
            "x"
          ];
          action = lib.nixvim.mkRaw "function() require('flash').treesitter_search() end";
          options = {
            desc = "Treesitter Search";
            silent = true;
          };
        }
        {
          key = "<c-s>";
          mode = [ "c" ];
          action = lib.nixvim.mkRaw "function() require('flash').toggle() end";
          options = {
            desc = "Toggle Flash Search";
            silent = true;
          };
        }
      ];
    };
}
