{ self, inputs, ... }:
{
  flake.nixvimModules.lint = { pkgs, lib, ... }: {
    plugins.lint = {
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
