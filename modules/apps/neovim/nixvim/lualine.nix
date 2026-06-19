{ self, inputs, ... }:
{
  flake.nixvimModules.lualine = { pkgs, lib, ... }: {
    colorschemes.lualine = {
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
