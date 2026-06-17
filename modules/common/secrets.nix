{ self, inputs, ... }: {
  flake.nixosModules.secretsCommon =
    { config, pkgs, ... }:
    {
      # imports = [ inputs.sops-nix.nixosModules.sops ];

      # Global sops-nix configuration shared across all hosts using this module
      # sops = {
      #   defaultSopsFile = ../secrets/secrets.yaml; # Adjust path to your encrypted sops file
      #   defaultSopsFormat = "yaml";
      #
      #   # Automatically use the machine's SSH key for decryption
      #   age.keyFile = "/var/lib/sops-nix/key.txt";
      #   sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      # };
    };
}
