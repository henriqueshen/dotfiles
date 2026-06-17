{ self, inputs, ... }: {
  flake.nixosConfigurations.minimal = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.minimalConfiguration
    ];
  };
}
