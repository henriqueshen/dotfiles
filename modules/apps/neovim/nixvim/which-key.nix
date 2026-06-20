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
            __unkeyed-1 = "<leader>l";
            group = "LSP";
          }
          {
            __unkeyed-1 = "<leader>q";
            group = "Quickfix";
          }
        ];
      };
    };
  };
}
