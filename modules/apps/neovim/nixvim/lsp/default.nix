{ self, inputs, ... }:
{
  flake.nixvimModules.lsp = { pkgs, lib, ... }: {
    imports = [
      self.nixvimModules.lsp-nix
      self.nixvimModules.lsp-lua
    ];

    plugins.lspconfig.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>ld";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.definition() end";
        lua = true;
        options = {
          desc = "Go to definition";
        };
      }
      {
        mode = "n";
        key = "<leader>le";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.declaration() end";
        lua = true;
        options = {
          desc = "Go to declaration";
        };
      }
      {
        mode = "n";
        key = "<leader>lt";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.references() end";
        lua = true;
        options = {
          desc = "List references";
        };
      }
      {
        mode = "n";
        key = "<leader>lf";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.format() end";
        lua = true;
        options = {
          desc = "Format buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>lh";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.hover() end";
        lua = true;
        options = {
          desc = "Hover under cursor";
        };
      }
      {
        mode = "n";
        key = "<leader>li";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.implementation() end";
        lua = true;
        options = {
          desc = "List implementations";
        };
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.rename() end";
        lua = true;
        options = {
          desc = "Rename references";
        };
      }
      {
        mode = "n";
        key = "<leader>lg";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.signature_help() end";
        lua = true;
        options = {
          desc = "Signature help";
        };
      }
      {
        mode = "n";
        key = "<leader>lj";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.typehierarchy('subtypes') end";
        lua = true;
        options = {
          desc = "Show type hierarchy (subtypes)";
        };
      }
      {
        mode = "n";
        key = "<leader>lk";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.typehierarchy('supertypes') end";
        lua = true;
        options = {
          desc = "Show type hierarchy (supertypes)";
        };
      }
      {
        mode = "n";
        key = "<leader>lc";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.incoming_calls() end";
        lua = true;
        options = {
          desc = "List call sites";
        };
      }
      {
        mode = "n";
        key = "<leader>la";
        action = lib.nixvim.mkRaw "function() vim.lsp.buf.code_action() end";
        lua = true;
        options = {
          desc = "Select a code action";
        };
      }
    ];
    lsp.keymaps = [ ];
  };
}
