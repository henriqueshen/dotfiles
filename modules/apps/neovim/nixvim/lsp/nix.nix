{ self, inputs, ... }:
{
  flake.nixvimModules.lsp-nix = { pkgs, lib, ... }: {
    lsp.servers = {
      nixd.enable = true;
    };
  };
}
