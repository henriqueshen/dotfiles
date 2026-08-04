{ self, inputs, ... }:
{
  flake.nixvimModules.tmux-navigator = { pkgs, lib, ... }: {
    plugins.tmux-navigator = {
      enable = true;
    };
  };
}
