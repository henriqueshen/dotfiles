{ config, inputs, ... }: {
  flake.nixosModules.theme = { pkgs, ... }: {
    imports = [
      inputs.stylix.nixosModules.stylix
    ];
    stylix = {
      enable = true;
      base16Scheme = ./cyberdream.yaml;
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
      };
    };
  };
  flake.homeModules.theme = { pkgs, ... }: {
    imports = [
      inputs.stylix.homeModules.stylix
    ];
    stylix = {
      enable = true;
      base16Scheme = ./cyberdream.yaml;
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
      };
    };
  };
}
