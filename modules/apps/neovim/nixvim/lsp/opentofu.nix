{ self, inputs, ... }:
{
  flake.nixvimModules.lsp-opentofu = { pkgs, lib, ... }: {
    lsp.servers = {
      tofu_ls = {
        enable = true;
      };
    };
  };
}
