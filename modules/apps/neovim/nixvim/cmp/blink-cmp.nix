{ self, inputs, ... }:
{
  flake.nixvimModules.blink-cmp = { pkgs, lib, ... }: {
    plugins.blink-cmp = {
      enable = true;

      settings = {
        appearance = {
          nerd_font_variant = "normal";
          use_nvim_cmp_as_default = true;
        };
        completion = {
          accept = {
            auto_brackets = {
              enabled = true;
              semantic_token_resolution = {
                enabled = true;
              };
            };
          };
          documentation = {
            auto_show = true;
          };
          ghost_text = {
            enabled = true;
          };
        };
        keymap = {
          preset = "default";
          "<C-d>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<C-e>" = [
            "hide"
            "fallback"
          ];
          "<CR>" = [
            "select_and_accept"
            "fallback"
          ];

          "<Up>" = [
            "select_prev"
            "fallback"
          ];
          "<Down>" = [
            "select_next"
            "fallback"
          ];
          "<C-k>" = [
            "select_prev"
            "fallback_to_mappings"
          ];
          "<C-j>" = [
            "select_next"
            "fallback_to_mappings"
          ];

          "<C-h>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-l>" = [
            "scroll_documentation_down"
            "fallback"
          ];

          "<Tab>" = [
            "snippet_forward"
            "fallback"
          ];
          "<S-Tab>" = [
            "snippet_backward"
            "fallback"
          ];

          "<C-s>" = [
            "show_signature"
            "hide_signature"
            "fallback"
          ];
        };

        signature = {
          enabled = true;
        };
        fuzzy = {
          implementation = "prefer_rust_with_warning";
        };
      };

      settings.sources.default = [
        "lsp"
        "path"
        "snippets"
        "buffer"
        "git"
      ];
    };
  };
}
