{ self, inputs, ... }: {
  flake.nixosModules.niri2 =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.programs.niri = {
        customSettings = lib.mkOption {
          type = lib.types.attrsOf lib.types.deferredModule;
          default = { };
          description = "Niri settings to override on top of the default package wrapper";
        };
      };

      config = {
        programs.niri = {
          enable = true;

          package = (
            self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri2.wrap config.programs.niri.customSettings
          );
        };
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.myNiri2 = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          spawn-at-startup = [ (lib.getExe self'.packages.myNoctalia) ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input.keyboard.xkb.layout = "us,ua";
        };
      };
    };
}
