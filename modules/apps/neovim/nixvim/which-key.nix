{ self, inputs, ... }:
{
  flake.nixvimModules.which-key = { pkgs, lib, ... }: {
    plugins.which-key = {
      enable = true;

      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>b";
            group = "Buffers";
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "Find";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "Git";
          }
          {
            __unkeyed-1 = "<leader>l";
            group = "LSP";
          }
          {
            __unkeyed-1 = "<leader>q";
            group = "Quickfix";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "Search";
          }
          {
            __unkeyed-1 = "<leader>u";
            group = "Utilities";
          }
          {
            __unkeyed-1 = "<leader>x";
            group = "Diagnostics";
          }
        ];
      };
    };
  };
}
