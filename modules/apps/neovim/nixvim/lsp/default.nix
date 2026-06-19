{ self, inputs, ... }:
{
  flake.nixvimModules.lsp = { pkgs, lib, ... }: {
    imports = [
      self.nixvimModules.lsp-nix
      self.nixvimModules.lsp-lua
    ];

    lsp = {
      enable = true;
    };

    keymaps = { };
  };
}
