{ self, inputs, ... }:
{
  flake.nixvimModules.lsp = { pkgs, lib, ... }: {
    imports = [
      self.nixvimModules.lsp-nix
      self.nixvimModules.lsp-lua
    ];

    plugins.lspconfig.enable = true;

    keymaps = [ ];
    lsp.keymaps = [ ];
  };
}
