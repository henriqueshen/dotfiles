{ self, inputs, ... }:
{
  flake.nixvimModules.default = { pkgs, lib, ... }: {
    imports = [
      self.nixvimModules.keymaps
      self.nixvimModules.options
      self.nixvimModules.colorscheme

      self.nixvimModules.lsp
      self.nixvimModules.treesitter

      self.nixvimModules.lualine
    ];
  };
}
