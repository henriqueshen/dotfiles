{ self, inputs, ... }: {
  flake.nixosModules.zsh =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.programs.zsh = {
        customSettings = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "zsh settings to override on top of the default package wrapper";
        };
      };

      config = {
        programs.zsh = {
          enable = true;

          package = (
            self.packages.${pkgs.stdenv.hostPlatform.system}.zsh.wrap config.programs.zsh.customSettings
          );
        };
      };
    };

  flake.homeModules.zsh =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.programs.zsh = {
        customSettings = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "zsh settings to override on top of the default package wrapper";
        };
      };

      config = {
        home.packages = [
          (self.packages.${pkgs.stdenv.hostPlatform.system}.zsh.wrap config.programs.zsh.customSettings)
        ];
      };
    };

  perSystem = { pkgs, lib, ... }: {
    packages.zsh = inputs.wrapper-modules.wrappers.zsh.wrap {
      inherit pkgs;

      zshAliases = {
        ngs = "sudo ${lib.getExe' pkgs.nix "nix-collect-garbage"}-d";
        ngu = "${lib.getExe' pkgs.nix "nix-collect-garbage"}-d";
        cd = "${lib.getExe pkgs.zoxide}";
        ls = "${lib.getExe pkgs.eza} --hyperlink --git --all";
        lst = "${lib.getExe pkgs.eza} --tree --recurse --level 2 --hyperlink --git --all";
        lsa =
          "${lib.getExe pkgs.eza} --tree --recurse --level 2 --hyperlink --long --header "
          + "--links --inode --mounts --blocksize --total-size "
          + "--modified --git --extended --all";
      };

      runtimePkgs = [
        pkgs.oh-my-zsh
        pkgs.zsh-autosuggestions
        pkgs.zsh-syntax-highlighting
        pkgs.zsh-vi-mode

        pkgs.nix
        pkgs.nixos-rebuild

        pkgs.zoxide
        pkgs.eza
      ];

      zshrc = {
        content = ''
          export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"

          nrs() {
            if [ -z "$1" ]; then
              echo "Usage: nrs <flake-target>"
              return 1
            fi

            sudo ${lib.getExe pkgs.nixos-rebuild} switch --flake ".#$1"
          }

          plugins=(
            git
            sudo
          )

          source $ZSH/oh-my-zsh.sh

          autoload -Uz compinit
          compinit

          source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
          source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
          source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        '';
      };
    };
  };
}
