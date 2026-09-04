{ self, inputs, ... }: {
  flake.nixosModules.zsh =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.zsh
      ];
    };

  flake.homeModules.zsh =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      programs.zsh = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.zsh;
      };
    };

  perSystem = { pkgs, lib, ... }:
    let
      configuredZsh = inputs.wrapper-modules.wrappers.zsh.wrap {
      inherit pkgs;

      zshAliases = {
        ngs = "sudo ${lib.getExe' pkgs.nix "nix-collect-garbage"} -d";
        ngu = "${lib.getExe' pkgs.nix "nix-collect-garbage"} -d";
        nu = "${lib.getExe pkgs.nix} flake update";
        ls = "${lib.getExe pkgs.eza} --hyperlink --git --all";
        lst = "${lib.getExe pkgs.eza} --tree --recurse --level 2 --hyperlink --git --all";
        lsa =
          "${lib.getExe pkgs.eza} --tree --recurse --level 2 --hyperlink --long --header "
          + "--links --inode --mounts --blocksize --total-size "
          + "--modified --git --extended --all";

        cc = ''CLAUDE_CONFIG_DIR="$HOME/.claude" claude'';
        cc1 = ''CLAUDE_CONFIG_DIR="$HOME/.claude.1" claude'';
      };

      runtimePkgs = with pkgs; [
        oh-my-zsh
        zsh-autosuggestions
        zsh-syntax-highlighting
        zsh-vi-mode

        nix
        nixos-rebuild

        starship
        zoxide
        eza
        devenv
      ];

      zshrc = {
        content = ''
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

          source ${pkgs.oh-my-zsh}/share/oh-my-zsh/oh-my-zsh.sh

          autoload -Uz compinit
          compinit

          source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
          source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
          source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

          eval "$(${lib.getExe pkgs.starship} init zsh)"
          eval "$(${lib.getExe pkgs.zoxide} init zsh --cmd cd)"
          eval "$(${lib.getExe pkgs.devenv} hook zsh)"
        '';
      };
    };
    in
    {
      packages.zsh = pkgs.symlinkJoin {
        name = "${configuredZsh.name}-orca-compatible";
        paths = [ configuredZsh ];
        nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
        meta = configuredZsh.meta // {
          outputsToInstall = [ "out" ];
        };
        passthru = {
          inherit (configuredZsh) ZDOTDIR shellPath;
        };
        postBuild = ''
          rm "$out/bin/zsh"

          # Orca temporarily replaces ZDOTDIR to install its shell-ready hook.
          # Preserve that override while retaining the generated zsh configuration.
          makeWrapper ${lib.getExe pkgs.zsh} "$out/bin/zsh" \
            --inherit-argv0 \
            --set-default ZDOTDIR ${lib.escapeShellArg configuredZsh.ZDOTDIR}
        '';
      };
    };
}
