{ self, inputs, ... }:
{
  flake.nixosModules.theme = {
    colorschemes.cyberdream.enable = true;
  };
}
