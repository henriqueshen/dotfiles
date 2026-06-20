{ self, inputs, ... }:
{
  flake.nixvimModules.conform-nvim = { pkgs, lib, ... }: {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };
      };
    };
  };
}
