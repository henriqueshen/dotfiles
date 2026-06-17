{ config, inputs, ... }: {
  flake.nixosModules.homeCommon = { ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
  flake.homeModules.homeCommon = { ... }: {

  };
}
