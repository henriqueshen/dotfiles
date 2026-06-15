{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myHomeModules.apps.tmux;
in
{
  options.myHomeModules.apps.tmux = {
    enable = lib.mkEnableOption "Enable user-level tmux configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
      fd
    ];

    programs.tmux = {
      enable = true;
    };
  };
}
