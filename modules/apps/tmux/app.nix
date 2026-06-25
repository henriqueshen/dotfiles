{ self, inputs, ... }: {
  flake.nixosModules.tmux =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.programs.tmux = {
        customSettings = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "tmux settings to override on top of the default package wrapper";
        };
      };

      config = {
        programs.tmux = {
          enable = true;

          package = (
            self.packages.${pkgs.stdenv.hostPlatform.system}.tmux.wrap config.programs.tmux.customSettings
          );
        };
      };
    };

  flake.homeModules.tmux =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.programs.tmux = {
        customSettings = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "tmux settings to override on top of the default package wrapper";
        };
      };

      config = {
        home.packages = [
          (self.packages.${pkgs.stdenv.hostPlatform.system}.tmux.wrap config.programs.tmux.customSettings)
        ];
      };
    };

  perSystem = { pkgs, ... }: {
    packages.tmux = inputs.wrapper-modules.wrappers.tmux.wrap {
      inherit pkgs;
      prefix = "C-Space";

      mouse = true;

      terminal = "screen-256color";

      baseIndex = 1;
      paneBaseIndex = 1;

      modeKeys = "vi";

      setEnvironment = {
        DOPPLER_TOKEN = "$(doppler configure get token --plain)";
      };

      plugins = [
        {
          plugin = pkgs.tmuxPlugins.sensible;
        }

        {
          plugin = pkgs.tmuxPlugins.vim-tmux-navigator;
        }

        {
          plugin = pkgs.tmuxPlugins.resurrect;

          configBefore = ''
            set -g @resurrect-strategy-nvim 'session'
          '';
        }

        {
          plugin = pkgs.fetchFromGitHub {
            owner = "vaaleyard";
            repo = "tmux-dotbar";
            tag = "0.3.3";
            hash = "sha256-CAKEN8Sk3t0nonV2R9df/DFTTUrVnbso0ZVGgeeGINM=";
          };

          relPath = "dotbar.tmux";

          configBefore = ''
            set -g @tmux-dotbar-bg "default"
            set -g @tmux-dotbar-right true
            set -g @tmux-dotbar-position top
          '';
        }
      ];

      configAfter = ''
        set -g extended-keys on
        set -g extended-keys-format csi-u

        bind -n M-0 select-window -t 0
        bind -n M-1 select-window -t 1
        bind -n M-2 select-window -t 2
        bind -n M-3 select-window -t 3
        bind -n M-4 select-window -t 4
        bind -n M-5 select-window -t 5
        bind -n M-6 select-window -t 6
        bind -n M-7 select-window -t 7
        bind -n M-8 select-window -t 8
        bind -n M-9 select-window -t 9

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi V send-keys -X select-line
        bind-key -T copy-mode-vi C-v send-keys -X select-block
        bind-key -T copy-mode-vi y \
          send-keys -X copy-pipe-and-cancel "xclip"

        bind c new-window -c "#{pane_current_path}"
        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"

        bind-key E new-window -c "#{pane_current_path}" "nvim"
        bind-key G new-window -c "#{pane_current_path}" "lazygit"
        bind-key C new-window -c "#{pane_current_path}" "lazydocker"
        bind-key N new-window -c "#{pane_current_path}" "nmtui"

        bind-key C-q new-window -c "#{pane_current_path}" "shutdown now"
        bind-key C-r new-window -c "#{pane_current_path}" "reboot"
        bind-key C-w new-window -c "#{pane_current_path}" \
          "sudo efibootmgr -n 0006 && reboot"

        bind d display-popup \
          -d "#{pane_current_path}" \
          -E "devcontainer up"

        bind-key D new-window \
          -c "#{pane_current_path}" \
          "devcontainer exec bash"

        bind C-d display-popup \
          -d "#{pane_current_path}" \
          -E \
          -w 80% \
          -h 40% \
          "bash -c '
            echo -n \"DevContainer Cmd: \"
            read cmd

            if [ -n \"\$cmd\" ]; then
              echo
              echo \"=== Running inside DevContainer ===\"
              devcontainer exec bash -li -c \"\$cmd\"
            fi

            echo
            echo \"=== Process finished. Press ENTER to close ===\"
            read
          '"

        set-option -g renumber-windows on

        run-shell \
          'tmux set-environment -g DOPPLER_TOKEN "$(doppler configure get token --plain)"'
      '';
    };
  };
}
