{ self, inputs, ... }:
{
  flake.nixvimModules.linter = { pkgs, lib, ... }: {
    imports = [
      self.nixvimModules.lint
    ];
  };
}
