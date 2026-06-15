{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myHomeModules.apps.neovim;
in
{
  options.myHomeModules.apps.neovim = {
    enable = lib.mkEnableOption "Enable customized Neovim configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
      fd
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
