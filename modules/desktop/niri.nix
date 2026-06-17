{ self, inputs, ... }: {
  flake.nixosModules.niri =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.programs.niri = {
        customSettings = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "Niri settings to override on top of the default package wrapper";
        };
      };

      config = {
        programs.niri = {
          enable = true;

          package = (
            self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri.wrap config.programs.niri.customSettings
          );
        };
      };
    };

  flake.homeManagerModules.niri =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.programs.niri = {
        customSettings = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "Niri settings to override on top of the default package wrapper";
        };
      };

      config = {
        home.packages = [
          (self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri.wrap config.programs.niri.customSettings)
        ];
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
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          spawn-at-startup = [ (lib.getExe self'.packages.myNoctalia) ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input.keyboard.xkb.layout = "us,ua";

          layout.gaps = 5;

          binds = {
            "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
            "Mod+Q".close-window = { };
            "Mod+R".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          };
        };
      };
    };
}
