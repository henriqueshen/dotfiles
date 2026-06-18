{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.nixosModules.secretsCommon =
    { config, pkgs, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      sops = {
        defaultSopsFile = ../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";

        age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };
    };
  flake.homeModules.secretsCommon =
    { config, pkgs, ... }:
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];
      sops = {
        defaultSopsFile = ../../secrets/users/${config.home.username}/secrets.yaml;
        defaultSopsFormat = "yaml";

        age.keyFile = "/run/secrets/users/${config.home.username}/sops/age-key";

        home.activation.reloadSystemdBeforeSops = lib.mkIf pkgs.stdenv.isLinux (
          lib.hm.dag.entryBetween [ "sops-nix" ] [ "reloadSystemd" ] ''
            # no-op: forces sops-nix to run after linkGeneration and reloadSystemd
          ''
        );
      };
    };
}
