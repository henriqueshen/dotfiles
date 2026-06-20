{ self, inputs, ... }:
{
  flake.nixvimModules.which-key = { pkgs, lib, ... }: {
    plugins.which-key = {
      enable = true;

      spec = [
        {
          __unkeyed-1 = "<leader>b";
          group = "Buffers";
        }
        {
          __unkeyed-1 = "<leader>f";
          group = "Find";
        }
      ];
    };
  };
}
