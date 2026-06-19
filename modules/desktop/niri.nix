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
            self.packages.${pkgs.stdenv.hostPlatform.system}.niri.wrap config.programs.niri.customSettings
          );
        };
      };
    };

  flake.homeModules.niri =
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
          (self.packages.${pkgs.stdenv.hostPlatform.system}.niri.wrap config.programs.niri.customSettings)
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
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          spawn-at-startup = [ (lib.getExe self'.packages.noctalia) ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input = {
            focus-follows-mouse = { };
            keyboard.xkb.layout = "us,ua";
            mouse = {
              accel-profile = "flat";
            };
          };

          prefer-no-csd = { };

          layout.gaps = 5;

          binds =
            let
              inherit (lib) getExe getExe';
              terminal = getExe pkgs.kitty;
              browser = getExe pkgs.firefox;
              fuzzel = getExe pkgs.fuzzel;
              swaylock = getExe pkgs.swaylock;
              orca = getExe pkgs.orca;
              playerctl = getExe pkgs.playerctl;
              brightnessctl = getExe pkgs.brightnessctl;
              wpctl = getExe' pkgs.wireplumber "wpctl";
            in
            {
              "Mod+Shift+Slash".show-hotkey-overlay = _: { };
              "Mod+Return".spawn = [ terminal ];
              "Mod+R".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call launcher toggle";
              "Mod+C".spawn = [ browser ];
              # "Mod+D".spawn = [ fuzzel ];
              "Super+Alt+L".spawn = [ swaylock ];
              "Super+Alt+S" = _: {
                props.allow-when-locked = true;
                content.spawn-sh = "pkill orca || exec ${orca}";
              };
              "XF86AudioRaiseVolume" = _: {
                props.allow-when-locked = true;
                content.spawn-sh = "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
              };
              "XF86AudioLowerVolume" = _: {
                props.allow-when-locked = true;
                content.spawn-sh = "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
              };
              "XF86AudioMute" = _: {
                props.allow-when-locked = true;
                content.spawn-sh = "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
              };
              "XF86AudioMicMute" = _: {
                props.allow-when-locked = true;
                content.spawn-sh = "${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
              };
              "XF86AudioPlay" = _: {
                props.allow-when-locked = true;
                content.spawn = [
                  playerctl
                  "play-pause"
                ];
              };
              "XF86AudioPause" = _: {
                props.allow-when-locked = true;
                content.spawn = [
                  playerctl
                  "play-pause"
                ];
              };
              "XF86AudioStop" = _: {
                props.allow-when-locked = true;
                content.spawn = [
                  playerctl
                  "stop"
                ];
              };
              "XF86AudioPrev" = _: {
                props.allow-when-locked = true;
                content.spawn = [
                  playerctl
                  "previous"
                ];
              };
              "XF86AudioNext" = _: {
                props.allow-when-locked = true;
                content.spawn = [
                  playerctl
                  "next"
                ];
              };
              "XF86MonBrightnessUp" = _: {
                props.allow-when-locked = true;
                content.spawn = [
                  brightnessctl
                  "--class=backlight"
                  "set"
                  "+10%"
                ];
              };
              "XF86MonBrightnessDown" = _: {
                props.allow-when-locked = true;
                content.spawn = [
                  brightnessctl
                  "--class=backlight"
                  "set"
                  "10%-"
                ];
              };
              "Mod+O".toggle-overview = _: { };
              "Mod+Q".close-window = _: { };
              "Mod+Left".focus-column-left = _: { };
              "Mod+Down".focus-window-down = _: { };
              "Mod+Up".focus-window-up = _: { };
              "Mod+Right".focus-column-right = _: { };
              "Mod+H".focus-column-left = _: { };
              "Mod+J".focus-window-down = _: { };
              "Mod+K".focus-window-up = _: { };
              "Mod+L".focus-column-right = _: { };
              "Mod+Ctrl+Left".move-column-left = _: { };
              "Mod+Ctrl+Down".move-window-down = _: { };
              "Mod+Ctrl+Up".move-window-up = _: { };
              "Mod+Ctrl+Right".move-column-right = _: { };
              "Mod+Ctrl+H".move-column-left = _: { };
              "Mod+Ctrl+J".move-window-down = _: { };
              "Mod+Ctrl+K".move-window-up = _: { };
              "Mod+Ctrl+L".move-column-right = _: { };
              "Mod+Home".focus-column-first = _: { };
              "Mod+End".focus-column-last = _: { };
              "Mod+Ctrl+Home".move-column-to-first = _: { };
              "Mod+Ctrl+End".move-column-to-last = _: { };
              "Mod+Shift+Left".focus-monitor-left = _: { };
              "Mod+Shift+Down".focus-monitor-down = _: { };
              "Mod+Shift+Up".focus-monitor-up = _: { };
              "Mod+Shift+Right".focus-monitor-right = _: { };
              "Mod+Page_Down".focus-workspace-down = _: { };
              "Mod+Page_Up".focus-workspace-up = _: { };
              "Mod+Ctrl+Page_Down".move-column-to-workspace-down = _: { };
              "Mod+Ctrl+Page_Up".move-column-to-workspace-up = _: { };
              "Mod+1".focus-workspace = 1;
              "Mod+2".focus-workspace = 2;
              "Mod+3".focus-workspace = 3;
              "Mod+4".focus-workspace = 4;
              "Mod+5".focus-workspace = 5;
              "Mod+6".focus-workspace = 6;
              "Mod+7".focus-workspace = 7;
              "Mod+8".focus-workspace = 8;
              "Mod+9".focus-workspace = 9;
              "Mod+Ctrl+1".move-column-to-workspace = 1;
              "Mod+Ctrl+2".move-column-to-workspace = 2;
              "Mod+Ctrl+3".move-column-to-workspace = 3;
              "Mod+Ctrl+4".move-column-to-workspace = 4;
              "Mod+Ctrl+5".move-column-to-workspace = 5;
              "Mod+Ctrl+6".move-column-to-workspace = 6;
              "Mod+Ctrl+7".move-column-to-workspace = 7;
              "Mod+Ctrl+8".move-column-to-workspace = 8;
              "Mod+Ctrl+9".move-column-to-workspace = 9;
              "Mod+BracketLeft".consume-or-expel-window-left = _: { };
              "Mod+BracketRight".consume-or-expel-window-right = _: { };
              "Mod+Comma".consume-window-into-column = _: { };
              "Mod+Period".expel-window-from-column = _: { };
              # "Mod+R".switch-preset-column-width = _: { };
              "Mod+Shift+R".switch-preset-column-width-back = _: { };
              "Mod+Ctrl+Shift+R".switch-preset-window-height = _: { };
              "Mod+Ctrl+R".reset-window-height = _: { };
              "Mod+F".maximize-column = _: { };
              "Mod+Shift+F".fullscreen-window = _: { };
              "Mod+M".maximize-window-to-edges = _: { };
              "Mod+Ctrl+F".expand-column-to-available-width = _: { };
              "Mod+C".center-column = _: { };
              "Mod+Ctrl+C".center-visible-columns = _: { };
              "Mod+Minus".set-column-width = "-10%";
              "Mod+Equal".set-column-width = "+10%";
              "Mod+Shift+Minus".set-window-height = "-10%";
              "Mod+Shift+Equal".set-window-height = "+10%";
              "Mod+V".toggle-window-floating = _: { };
              "Mod+Shift+V".switch-focus-between-floating-and-tiling = _: { };
              "Mod+W".toggle-column-tabbed-display = _: { };
              "Print".screenshot = _: { };
              "Ctrl+Print".screenshot-screen = _: { };
              "Alt+Print".screenshot-window = _: { };
              "Mod+Escape" = _: {
                props.allow-inhibiting = false;
                content.toggle-keyboard-shortcuts-inhibit = _: { };
              };
              "Mod+Shift+E".quit = _: { };
              "Ctrl+Alt+Delete".quit = _: { };
              "Mod+Shift+P".power-off-monitors = _: { };
            };
        };
      };
    };
}
