{ self, inputs, ... }:
{
  flake.homeModules.ai = { pkgs, lib, ... }: {
    imports = [
      self.homeModules.herdr
      self.homeModules.orca
      self.homeModules.claude-code
      self.homeModules.codex
      self.homeModules.pi
      self.homeModules.omp
      self.homeModules.docs-standards
    ];
  };
}
