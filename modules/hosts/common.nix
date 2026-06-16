{ self, inputs, ... }: {
  flake.nixosModules.hostsCommon =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        git
        neovim
      ];
    };
}
