{ self, inputs, ... }:
{
  flake.nixvimModules.lsp-yaml = { pkgs, lib, ... }: {
    lsp.servers = {
      yamlls = {
        enable = true;
      };
      helm_ls = {
        enable = true;
      };
    };
  };
}
