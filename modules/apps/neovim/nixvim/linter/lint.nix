{ self, inputs, ... }:
{
  flake.nixvimModules.lint = { pkgs, lib, ... }: {
    plugins.lint = {
      enable = true;
      autoInstall.enable = true;
      autoCmd = {
        callback = {
          __raw = ''
            function()
              require('lint').try_lint()
            end
          '';
        };
        event = "BufWritePost";
      };
      lintersByFt = { };
    };
  };
}
