{ self, inputs, ... }:
{
  flake.nixvimModules.theme = {
    colorschemes.cyberdream.enable = true;
  };
}
