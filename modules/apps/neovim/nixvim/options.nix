{ self, inputs, ... }:
{
  flake.nixvimModules.options = { pkgs, lib, ... }: {
    opts = {
      jumpoptions = "stack,view";
      number = true;
      relativenumber = false;
      cursorline = true;
      tabstop = 2;
      shiftwidth = 2;
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
      undofile = true;
      swapfile = false;
      foldlevel = 99;
      foldlevelstart = 99;
    };
    clipboard.register = "unnamedplus";
  };
}
