{ self, inputs, ... }:
{
  flake.nixvimModules.lsp = { pkgs, lib, ... }: {
    lsp = {
      enable = true;
    };

    servers = {
      nixd.enable = true;
    };
  };
}
