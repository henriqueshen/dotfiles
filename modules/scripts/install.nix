{ self, inputs, ... }: {
  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.install = pkgs.writeShellScriptBin "install-nixos" ''
        set -euox pipefail

        TARGET_IP=$1
        FLAKE_TARGET=$2

        if [ -z "$TARGET_IP" ] || [ -z "$FLAKE_TARGET" ]; then
          echo "Usage: nix run .#install <TARGET_IP> <FLAKE_TARGET>"
          exit 1
        fi

        KEY_DIR="./tmp-host-keys/etc/ssh"

        if [ ! -f "$KEY_DIR/ssh_host_ed25519_key" ]; then
          echo "No pre-existing host key found. Generating keys..."
          mkdir -p "$KEY_DIR"
          ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -N "" -f "$KEY_DIR/ssh_host_ed25519_key"
          
          echo "=========================================================="
          echo "NEW MACHINE AGE PUBLIC KEY IS:"
          ${pkgs.ssh-to-age}/bin/ssh-to-age < "$KEY_DIR/ssh_host_ed25519_key.pub"
          echo "=========================================================="
          echo "Action Needed: Copy this age key into your .sops.yaml rules,"
          echo "run 'sops secrets.yaml' to update encryption, then re-run this script."
          exit 0
        fi

        echo "Host key verified. Triggering nixos-anywhere..."
        ${pkgs.nix}/bin/nix run github:nix-community/nixos-anywhere -- \
          --extra-files ./tmp-host-keys \
          --flake .#"$FLAKE_TARGET" \
          root@"$TARGET_IP"
      '';
    };
}
