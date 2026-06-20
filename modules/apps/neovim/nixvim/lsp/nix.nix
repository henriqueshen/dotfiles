{ self, inputs, ... }:
{
  flake.nixvimModules.lsp-nix = { pkgs, lib, ... }: {
    lsp = {
      enable = true;
    };

    servers = {
      nixd.enable = true;
    };
  };
}
