{ self, inputs, ... }:
{
  flake.nixvimModules.snacks = { pkgs, lib, ... }: {
    extraPackages = with pkgs; [
      git
      fd
      ripgrep
      fzf
      chafa

      pokemon-colorscripts
    ];

    plugins.snacks = {
      enable = true;
      settings = {
        bigfile.enabled = true;
        zen.enabled = false;
        explorer.enabled = true;
        indent.enabled = true;
        input.enabled = true;
        quickfile.enabled = true;
        scope.enabled = true;
        scroll.enabled = false;
        statuscolumn.enabled = true;
        words.enabled = true;

        notifier = {
          enabled = true;
          timeout = 3000;
        };

        picker = {
          enabled = true;
          hidden = true;
          ignored = true;
          sources = {
            files = {
              hidden = true;
              ignored = true;
            };
            explorer = {
              layout.layout.position = "right";
            };
          };
        };

        styles = {
          notification.wo.wrap = true;
        };

        dashboard = {
          enabled = true;
          sections = [
            {
              pane = 1;
              section = "terminal";
              cmd = "${lib.getExe pkgs.pokemon-colorscripts} --name pikachu --no-title";
              height = 10;
              padding = 1;
              indent = 18;
            }
            {
              section = "keys";
              gap = 1;
              padding = 1;
            }
            {
              pane = 2;
              icon = " ";
              title = "Recent Files";
              section = "recent_files";
              indent = 2;
              padding = 1;
            }
            {
              pane = 2;
              icon = " ";
              title = "Projects";
              section = "projects";
              indent = 2;
              padding = 1;
            }
            {
              pane = 2;
              icon = " ";
              title = "Git Status";
              section = "terminal";
              cmd = "${lib.getExe pkgs.git} status --short --branch --renames";
              height = 5;
              padding = 1;
              ttl = 300;
              indent = 3;
              enabled.__raw = ''
                function() 
                  return Snacks.git.get_root() ~= nil 
                end
              '';
            }
            {
              section = "startup";
            }
          ];
        };
      };
    };
    keymaps = [
      {
        key = "<leader>fs";
        action = lib.nixvim.mkRaw "function() Snacks.picker.smart() end";
        options.desc = "Smart Find Files";
      }

      {
        key = "<leader>fl";
        action = lib.nixvim.mkRaw "function() Snacks.picker.live_grep() end";
        options.desc = "Live Grep";
      }

      {
        key = "<leader>fw";
        action = lib.nixvim.mkRaw "function() Snacks.picker.word_grep() end";
        options.desc = "Word Grep";
      }

      {
        key = "<leader>fx";
        action = lib.nixvim.mkRaw "function() Snacks.picker.grep() end";
        options.desc = "Grep";
      }

      {
        key = "<leader>fe";
        action = lib.nixvim.mkRaw "function() Snacks.explorer() end";
        options.desc = "File Explorer";
      }

      {
        key = "<leader>fb";
        action = lib.nixvim.mkRaw "function() Snacks.picker.buffers() end";
        options.desc = "Buffers";
      }

      {
        key = "<leader>fc";
        action = lib.nixvim.mkRaw "function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end";
        options.desc = "Find Config File";
      }

      {
        key = "<leader>ff";
        action = lib.nixvim.mkRaw "function() Snacks.picker.files() end";
        options.desc = "Find Files";
      }

      {
        key = "<leader>fh";
        action = lib.nixvim.mkRaw "function() Snacks.picker.command_history() end";
        options.desc = "Command History";
      }

      {
        key = "<leader>fg";
        action = lib.nixvim.mkRaw "function() Snacks.picker.git_files() end";
        options.desc = "Find Git Files";
      }

      {
        key = "<leader>fp";
        action = lib.nixvim.mkRaw "function() Snacks.picker.projects() end";
        options.desc = "Projects";
      }

      {
        key = "<leader>fr";
        action = lib.nixvim.mkRaw "function() Snacks.picker.recent() end";
        options.desc = "Recent";
      }

      {
        key = "<leader>fn";
        action = lib.nixvim.mkRaw "function() Snacks.picker.notifications() end";
        options.desc = "Notification History";
      }

      {
        key = "<leader>gb";
        action = lib.nixvim.mkRaw "function() Snacks.picker.git_branches() end";
        options.desc = "Git Branches";
      }

      {
        key = "<leader>gl";
        action = lib.nixvim.mkRaw "function() Snacks.picker.git_log() end";
        options.desc = "Git Log";
      }

      {
        key = "<leader>gL";
        action = lib.nixvim.mkRaw "function() Snacks.picker.git_log_line() end";
        options.desc = "Git Log Line";
      }

      {
        key = "<leader>gs";
        action = lib.nixvim.mkRaw "function() Snacks.picker.git_status() end";
        options.desc = "Git Status";
      }

      {
        key = "<leader>gS";
        action = lib.nixvim.mkRaw "function() Snacks.picker.git_stash() end";
        options.desc = "Git Stash";
      }

      {
        key = "<leader>gd";
        action = lib.nixvim.mkRaw "function() Snacks.picker.git_diff() end";
        options.desc = "Git Diff (Hunks)";
      }

      {
        key = "<leader>gf";
        action = lib.nixvim.mkRaw "function() Snacks.picker.git_log_file() end";
        options.desc = "Git Log File";
      }

      {
        key = "<leader>gi";
        action = lib.nixvim.mkRaw "function() Snacks.picker.gh_issue() end";
        options.desc = "GitHub Issues (open)";
      }

      {
        key = "<leader>gI";
        action = lib.nixvim.mkRaw "function() Snacks.picker.gh_issue({ state = 'all' }) end";
        options.desc = "GitHub Issues (all)";
      }

      {
        key = "<leader>gp";
        action = lib.nixvim.mkRaw "function() Snacks.picker.gh_pr() end";
        options.desc = "GitHub Pull Requests (open)";
      }

      {
        key = "<leader>gP";
        action = lib.nixvim.mkRaw "function() Snacks.picker.gh_pr({ state = 'all' }) end";
        options.desc = "GitHub Pull Requests (all)";
      }

      {
        key = "<leader>lsr";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_references() end";
        options.desc = "Search LSP References";
      }

      {
        key = "<leader>lsd";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_definitions() end";
        options.desc = "Search LSP Definitions";
      }

      {
        key = "<leader>lsc";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_declarations() end";
        options.desc = "Search LSP Declarations";
      }

      {
        key = "<leader>lsp";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_implementations() end";
        options.desc = "Search LSP Implementations";
      }

      {
        key = "<leader>lss";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_workspace_symbols() end";
        options.desc = "Search LSP Workspace Symbols";
      }

      {
        key = "<leader>lst";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_type_definitions() end";
        options.desc = "Search Type Definition";
      }

      {
        key = "<leader>lsi";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_incoming_calls() end";
        options.desc = "Search LSP Incoming Calls";
      }

      {
        key = "<leader>lso";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_outgoing_calls() end";
        options.desc = "Search LSP Outgoing Calls";
      }

      {
        key = "<leader>lsy";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_symbols() end";
        options.desc = "Search LSP Symbols";
      }

      {
        key = "<leader>sb";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lines() end";
        options.desc = "Buffer Lines";
      }

      {
        key = "<leader>sB";
        action = lib.nixvim.mkRaw "function() Snacks.picker.grep_buffers() end";
        options.desc = "Grep Open Buffers";
      }

      {
        key = "<leader>sg";
        action = lib.nixvim.mkRaw "function() Snacks.picker.grep() end";
        options.desc = "Grep";
      }

      {
        key = "<leader>sw";
        mode = [
          "n"
          "x"
        ];
        action = lib.nixvim.mkRaw "function() Snacks.picker.grep_word() end";
        options.desc = "Visual selection or word";
      }

      {
        key = "<leader>uZ";
        action = lib.nixvim.mkRaw "function() Snacks.zen.zoom() end";
        options.desc = "Toggle Zoom";
      }

      {
        key = "<leader>u.";
        action = lib.nixvim.mkRaw "function() Snacks.scratch() end";
        options.desc = "Toggle Scratch Buffer";
      }

      {
        key = "<leader>uS";
        action = lib.nixvim.mkRaw "function() Snacks.scratch.select() end";
        options.desc = "Select Scratch Buffer";
      }

      {
        key = "<leader>bd";
        action = lib.nixvim.mkRaw "function() Snacks.bufdelete() end";
        options.desc = "Delete Buffer";
      }

      {
        key = "<leader>cR";
        action = lib.nixvim.mkRaw "function() Snacks.rename.rename_file() end";
        options.desc = "Rename File";
      }

      {
        key = "<leader>gB";
        mode = [
          "n"
          "v"
        ];
        action = lib.nixvim.mkRaw "function() Snacks.gitbrowse() end";
        options.desc = "Git Browse";
      }

      {
        key = "<leader>gg";
        action = lib.nixvim.mkRaw "function() Snacks.lazygit() end";
        options.desc = "Lazygit";
      }

      {
        key = "<leader>un";
        action = lib.nixvim.mkRaw "function() Snacks.notifier.hide() end";
        options.desc = "Dismiss All Notifications";
      }

      {
        key = "<C-_>";
        action = lib.nixvim.mkRaw "function() Snacks.terminal() end";
        options.desc = "which_key_ignore";
      }

      {
        key = "]]";
        mode = [
          "n"
          "t"
        ];
        action = lib.nixvim.mkRaw "function() Snacks.words.jump(vim.v.count1) end";
        options.desc = "Next Reference";
      }

      {
        key = "[[";
        mode = [
          "n"
          "t"
        ];
        action = lib.nixvim.mkRaw "function() Snacks.words.jump(-vim.v.count1) end";
        options.desc = "Prev Reference";
      }

      {
        key = "gd";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_definitions() end";
        options.desc = "Goto Definition";
      }

      {
        key = "gD";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_declarations() end";
        options.desc = "Goto Declaration";
      }

      {
        key = "gr";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_references() end";
        options = {
          desc = "References";
          nowait = true;
        };
      }

      {
        key = "gI";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_implementations() end";
        options.desc = "Goto Implementation";
      }

      {
        key = "gy";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_type_definitions() end";
        options.desc = "Goto Type Definition";
      }

      {
        key = "gai";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_incoming_calls() end";
        options.desc = "Calls Incoming";
      }

      {
        key = "gao";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_outgoing_calls() end";
        options.desc = "Calls Outgoing";
      }

      {
        key = "<leader>s\"";
        action = lib.nixvim.mkRaw "function() Snacks.picker.registers() end";
        options.desc = "Registers";
      }

      {
        key = "<leader>s/";
        action = lib.nixvim.mkRaw "function() Snacks.picker.search_history() end";
        options.desc = "Search History";
      }

      {
        key = "<leader>sa";
        action = lib.nixvim.mkRaw "function() Snacks.picker.autocmds() end";
        options.desc = "Autocmds";
      }

      {
        key = "<leader>sc";
        action = lib.nixvim.mkRaw "function() Snacks.picker.command_history() end";
        options.desc = "Command History";
      }

      {
        key = "<leader>sC";
        action = lib.nixvim.mkRaw "function() Snacks.picker.commands() end";
        options.desc = "Commands";
      }

      {
        key = "<leader>sd";
        action = lib.nixvim.mkRaw "function() Snacks.picker.diagnostics() end";
        options.desc = "Diagnostics";
      }

      {
        key = "<leader>sD";
        action = lib.nixvim.mkRaw "function() Snacks.picker.diagnostics_buffer() end";
        options.desc = "Buffer Diagnostics";
      }

      {
        key = "<leader>sh";
        action = lib.nixvim.mkRaw "function() Snacks.picker.help() end";
        options.desc = "Help Pages";
      }

      {
        key = "<leader>sH";
        action = lib.nixvim.mkRaw "function() Snacks.picker.highlights() end";
        options.desc = "Highlights";
      }

      {
        key = "<leader>si";
        action = lib.nixvim.mkRaw "function() Snacks.picker.icons() end";
        options.desc = "Icons";
      }

      {
        key = "<leader>sj";
        action = lib.nixvim.mkRaw "function() Snacks.picker.jumps() end";
        options.desc = "Jumps";
      }

      {
        key = "<leader>sk";
        action = lib.nixvim.mkRaw "function() Snacks.picker.keymaps() end";
        options.desc = "Keymaps";
      }

      {
        key = "<leader>sl";
        action = lib.nixvim.mkRaw "function() Snacks.picker.loclist() end";
        options.desc = "Location List";
      }

      {
        key = "<leader>sm";
        action = lib.nixvim.mkRaw "function() Snacks.picker.marks() end";
        options.desc = "Marks";
      }

      {
        key = "<leader>sM";
        action = lib.nixvim.mkRaw "function() Snacks.picker.man() end";
        options.desc = "Man Pages";
      }

      {
        key = "<leader>sp";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lazy() end";
        options.desc = "Search for Plugin Spec";
      }

      {
        key = "<leader>sq";
        action = lib.nixvim.mkRaw "function() Snacks.picker.qflist() end";
        options.desc = "Quickfix List";
      }

      {
        key = "<leader>sR";
        action = lib.nixvim.mkRaw "function() Snacks.picker.resume() end";
        options.desc = "Resume";
      }

      {
        key = "<leader>su";
        action = lib.nixvim.mkRaw "function() Snacks.picker.undo() end";
        options.desc = "Undo History";
      }

      {
        key = "<leader>uC";
        action = lib.nixvim.mkRaw "function() Snacks.picker.colorschemes() end";
        options.desc = "Colorschemes";
      }

      {
        key = "<leader>ss";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_symbols() end";
        options.desc = "LSP Symbols";
      }

      {
        key = "<leader>sS";
        action = lib.nixvim.mkRaw "function() Snacks.picker.lsp_workspace_symbols() end";
        options.desc = "LSP Workspace Symbols";
      }

      {
        key = "<leader>uN";
        action = lib.nixvim.mkRaw ''
          function()
            Snacks.win({
              file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
              width = 0.6,
              height = 0.6,
              wo = {
                spell = false,
                wrap = false,
                signcolumn = "yes",
                statuscolumn = " ",
                conceallevel = 3,
              },
            })
          end
        '';
        options.desc = "Neovim News";
      }
    ];
  };
}
