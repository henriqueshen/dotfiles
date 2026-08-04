{ self, inputs, ... }:
{
  flake.nixvimModules.lsp-protobuf = { pkgs, lib, ... }: {
    lsp.servers = {
      buf_ls.enable = true;
    };
  };
}
