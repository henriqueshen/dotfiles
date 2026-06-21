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
          # cmd = [
          #   "rustup"
          #   "run"
          #   "nightly"
          #   "rust-analyzer"
          # ];
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
          standalone = false;
        };
      };
    };
  };
}
