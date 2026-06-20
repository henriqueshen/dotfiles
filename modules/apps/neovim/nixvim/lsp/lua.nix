{ self, inputs, ... }:
{
  flake.nixvimModules.lsp-lua = { pkgs, lib, ... }: {
    lsp.servers = {
      lua_ls = {
        enable = true;
        settings.Lua.diagnostics.globals = [ "vim" ];
      };
    };
  };
}
