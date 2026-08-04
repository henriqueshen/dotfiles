{ self, inputs, ... }:
{
  flake.nixvimModules.lualine = { pkgs, lib, ... }: {
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          theme = "auto";
          section_separators = {
            left = "";
            right = "";
          };
          component_separators = {
            left = "";
            right = "";
          };
        };
      };
    };
  };
}
