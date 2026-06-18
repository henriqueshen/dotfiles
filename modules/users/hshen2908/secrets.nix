{ self, inputs, ... }: {
  flake.nixosModules.hshen2908Secrets =
    { config, pkgs, ... }:
    {
      # imports = [ self.nixosModules.secretsCommon ];
      #
      # sops.secrets."hshen2908/sops/age-key" = {
      #   owner = "hshen2908";
      # };
    };
}
