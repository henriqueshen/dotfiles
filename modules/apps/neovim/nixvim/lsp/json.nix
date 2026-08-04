{ self, inputs, ... }:
{
  flake.nixvimModules.lsp-json = { pkgs, lib, ... }: {
    lsp.servers = {
      jsonls = {
        enable = true;
      };
    };
  };
}
