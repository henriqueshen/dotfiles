{ self, inputs, ... }:
{
  flake.nixvimModules.options = { pkgs, lib, ... }: {
    opts = {
      jumpoptions = "stack,view";
      number = true;
      relativenumber = false;
      cursorline = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
      breakindent = true;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      background = "dark";
      signcolumn = "yes";
      backspace = "indent,eol,start";
      splitright = true;
      splitbelow = true;
      swapfile = false;
    };
    clipboard.register = "unnamedplus";
  };
}
