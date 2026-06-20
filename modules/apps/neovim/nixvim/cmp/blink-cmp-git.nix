{ self, inputs, ... }:
{
  flake.nixvimModules.blink-cmp-git = { pkgs, lib, ... }: {
    plugins.blink-cmp = {
      enable = true;

      settings.sources.providers = {
        git = {
          module = "blink-cmp-git";
          name = "git";
          score_offset = 100;
          opts = {
            commit = { };
            git_centers = {
              git_hub = { };
            };
          };
        };
      };
    };

  };
}
