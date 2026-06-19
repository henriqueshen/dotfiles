{ self, inputs, ... }:
{
  flake.nixvimModules.lsp = { pkgs, lib, ... }: {
    servers = {
      nixd.enable = true;
    };
  };
}
