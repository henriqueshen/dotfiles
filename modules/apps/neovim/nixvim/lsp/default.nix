{ self, inputs, ... }:
{
  flake.nixvimModules.lsp = { pkgs, lib, ... }: {
    imports = [
      self.nixvimModules.lsp-nix
      self.nixvimModules.lsp-lua
      self.nixvimModules.lsp-rust
      self.nixvimModules.lsp-toml
      self.nixvimModules.lsp-yaml
      self.nixvimModules.lsp-json
      self.nixvimModules.lsp-opentofu
      self.nixvimModules.lsp-protobuf
    ];

    extraConfigLua = ''
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          prefix = "●",
          source = "if_many",
        },
        severity_sort = true,
        update_in_insert = true,
      })
    '';

    plugins.lspconfig.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>ld";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.definition() end";
        options = {
          desc = "Go to definition";
        };
      }
      {
        mode = "n";
        key = "<leader>le";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.declaration() end";
        options = {
          desc = "Go to declaration";
        };
      }
      {
        mode = "n";
        key = "<leader>lt";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.references() end";
        options = {
          desc = "List references";
        };
      }
      {
        mode = "n";
        key = "<leader>lf";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.format() end";
        options = {
          desc = "Format buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>lh";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.hover() end";
        options = {
          desc = "Hover under cursor";
        };
      }
      {
        mode = "n";
        key = "<leader>li";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.implementation() end";
        options = {
          desc = "List implementations";
        };
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.rename() end";
        options = {
          desc = "Rename references";
        };
      }
      {
        mode = "n";
        key = "<leader>lg";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.signature_help() end";
        options = {
          desc = "Signature help";
        };
      }
      {
        mode = "n";
        key = "<leader>lj";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.typehierarchy('subtypes') end";
        options = {
          desc = "Show type hierarchy (subtypes)";
        };
      }
      {
        mode = "n";
        key = "<leader>lk";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.typehierarchy('supertypes') end";
        options = {
          desc = "Show type hierarchy (supertypes)";
        };
      }
      {
        mode = "n";
        key = "<leader>lc";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.incoming_calls() end";
        options = {
          desc = "List call sites";
        };
      }
      {
        mode = "n";
        key = "<leader>la";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.code_action() end";
        options = {
          desc = "Select a code action";
        };
      }
      {
        mode = "n";
        key = "<leader>lt";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines }) end";
        options = {
          desc = "Toggle diagnostic virtual lines";
        };
      }
    ];
    lsp.keymaps = [ ];
  };
}
