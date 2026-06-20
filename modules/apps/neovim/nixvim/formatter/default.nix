{ self, inputs, ... }:
{
  flake.nixvimModules.formatter = { pkgs, lib, ... }: {
    imports = [
      self.nixvimModules.conform-nvim
    ];
  };
}
