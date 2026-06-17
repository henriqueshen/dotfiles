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

      environment.systemPackages = with pkgs; [
        git
        neovim
      ];
    };
}
