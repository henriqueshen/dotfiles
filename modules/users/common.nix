{ config, inputs, ... }: {
  flake.nixosModules.usersCommon = { ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
  flake.homeModules.usersCommon = { ... }: {

  };
}
