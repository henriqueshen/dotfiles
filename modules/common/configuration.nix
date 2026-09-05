{ self, inputs, ... }: {
  flake.nixosModules.configurationCommon =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        extra-substituters = [ "https://cache.numtide.com" ];
        extra-trusted-public-keys = [
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        ];
      };

      nixpkgs.config.allowUnfree = true;

      # nix.gc = {
      #   automatic = true;
      #   dates = "weekly";
      #   options = "--delete-older-than 7d";
      # };

      environment.systemPackages = with pkgs; [
        git
        vim
      ];
    };
}
