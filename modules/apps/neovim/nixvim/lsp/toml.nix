{ self, inputs, ... }:
{
  flake.nixvimModules.lsp-toml = { pkgs, lib, ... }: {
    lsp.servers = {
      tombi = {
        enable = true;
      };
    };
  };
}
