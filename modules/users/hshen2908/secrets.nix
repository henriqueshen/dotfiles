{ self, inputs, ... }: {
  flake.nixosModules.hshen2908Secrets =
    { config, pkgs, ... }:
    {
      imports = [ self.nixosModules.secretsCommon ];

      sops.secrets."users/hshen2908/sops/age-key" = {
        owner = "hshen2908";
        # path = "${config.home-manager.users.hshen2908.home.homeDirectory}/.config/sops/age/keys.txt";
      };
    };
}
