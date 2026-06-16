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
        outputs = lib.mkOption {
          type = lib.types.attrsOf lib.types.anything;
          default = { };
          description = "Host specific display and output configuration for niri";
        };
      };
      config = lib.mkIf config.programs.niri.enable {
        programs.niri.package = inputs.wrapper-modules.wrappers.niri.wrap {
          inherit pkgs;
          settings = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri.settings {
            output = config.programs.niri.outputs;
          };
        };
      };
      # programs.niri = {
      #   enable = true;
      #   package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      # };
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
          spawn-at-startup = [
            (lib.getExe self'.packages.myNoctalia)
          ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input.keyboard.xkb.layout = "us,ua";

          layout.gaps = 5;

          binds = {
            "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
            "Mod+Q".close-window = { };
            "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          };
        };
      };
    };
}
