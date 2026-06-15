{ pkgs, ... }: {

  imports = [ ../../modules/apps ]; # Loads all app modules silently

  home.username = "hshen2908";
  home.homeDirectory = "/home/hshen2908";
  home.stateVersion = "23.11"; # Read home-manager release notes before changing

  myHomeModules.apps.neovim.enable = true;
  myHomeModules.apps.tmux.enable = false;

  programs.git = {
    enable = true;
    userName = "Henrique Shen";
    userEmail = "alice@example.com";
  };

  home.packages = with pkgs; [
    vscode
    firefox
  ];
}
