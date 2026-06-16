{ self, inputs, ... }: {
  flake.nixosModules.hshen2908 =
    { config, pkgs, ... }:
    {
      imports = [ ];

      users.users."hshen2908" = {
        isNormalUser = true;
        description = "Henique Shen";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.zsh;
        packages = with pkgs; [ ];
      };
      programs.zsh.enable = true;

      home-manager = {
        users."hshen2908" = self.homeModules.hshen2908;
      };
    };
}
