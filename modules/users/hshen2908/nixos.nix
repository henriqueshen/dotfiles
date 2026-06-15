{ pkgs, ... }: {
  users.users.hshen2908 = {
    isNormalUser = true;
    description = "Henrique Shen";
    extraGroups = [
      "users"
      "wheel"
      "networkmanager"
      "docker"
    ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
}
