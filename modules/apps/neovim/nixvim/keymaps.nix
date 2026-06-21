{ self, inputs, ... }:
{
  flake.nixvimModules.keymaps = { pkgs, lib, ... }: {
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };
    keymaps = [
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          silent = true;
          desc = "Go to Left Window";
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          silent = true;
          desc = "Go to Lower Window";
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          silent = true;
          desc = "Go to Upper Window";
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          silent = true;
          desc = "Go to Right Window";
        };
      }
    ];
  };
}
