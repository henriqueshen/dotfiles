{ self, inputs, ... }:
{
  flake.homeModules.ai = { pkgs, lib, ... }: {
    imports = [
      self.homeModules.herdr
      self.homeModules.claude-code
      self.homeModules.codex
    ];
  };
}
