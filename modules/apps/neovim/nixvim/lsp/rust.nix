{ self, inputs, ... }:
{
  flake.nixvimModules.lsp-rust = { pkgs, lib, ... }: {
    extraPackages = with pkgs; [
      rust-analyzer
      cargo
      rustc
    ];

    plugins.rustaceanvim = {
      enable = true;
      settings = {
        server = {
          default_settings = {
            rust-analyzer = {
              cargo = {
                allFeatures = true;
              };
              check = {
                command = "clippy";
              };
              inlayHints = {
                lifetimeElisionHints = {
                  enable = "always";
                };
              };
            };
          };
        };
      };
    };
  };
}
