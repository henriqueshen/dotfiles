{ self, inputs, ... }: {
  flake.nixosModules.hshen2908 =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.userCommon

        self.nixosModules.hshen2908Home
        self.nixosModules.hshen2908Secrets

        self.nixosModules.zsh
      ];

      users.users."hshen2908" = {
        isNormalUser = true;
        description = "Henique Shen";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = self.packages.${pkgs.stdenv.hostPlatform.system}.zsh;
        packages = with pkgs; [ ];
      };
    };
}
