{ self, inputs, ... }: {
  flake.nixosModules.hshen2908 =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.userCommon

        self.nixosModules.hshen2908Home
        self.nixosModules.hshen2908Secrets
      ];

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
    };
}
