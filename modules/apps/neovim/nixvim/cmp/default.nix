{ self, inputs, ... }:
{
  flake.nixvimModules.cmp = { pkgs, lib, ... }: {
    imports = [
      self.nixvimModules.blink-cmp
      self.nixvimModules.blink-cmp-git

      self.nixvimModules.blink-pairs
    ];
  };
}
