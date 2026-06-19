{ self, inputs, ... }: {
  flake.nixosModules.configurationCommon =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixpkgs.config.allowUnfree = true;

      # nix.gc = {
      #   automatic = true;
      #   dates = "weekly";
      #   options = "--delete-older-than 7d";
      # };

      environment.systemPackages = with pkgs; [
        git
        neovim
      ];
    };
}
