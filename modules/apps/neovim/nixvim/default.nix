{ self, inputs, ... }:
{
  flake.nixvimModules.default = { pkgs, lib, ... }: {
    imports = [
      self.nixvimModules.keymaps
      self.nixvimModules.options
      self.nixvimModules.colorscheme

      self.nixvimModules.lazy-loading

      self.nixvimModules.lsp
      self.nixvimModules.linter
      self.nixvimModules.formatter
      self.nixvimModules.dap
      self.nixvimModules.cmp
      self.nixvimModules.treesitter

      self.nixvimModules.lualine
      self.nixvimModules.which-key
      self.nixvimModules.snacks
      self.nixvimModules.trouble
      self.nixvimModules.flash
      self.nixvimModules.tmux-navigator
      self.nixvimModules.quicker
      self.nixvimModules.nvim-bqf
    ];
  };
}
