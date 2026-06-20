{ self, inputs, ... }:
{
  flake.nixvimModules.lsp-nix = { pkgs, lib, ... }: {
    servers = {
      nixd.enable = true;
    };
  };
}
