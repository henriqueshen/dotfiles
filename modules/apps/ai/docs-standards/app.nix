{ self, inputs, ... }: {
  flake.homeModules.docs-standards =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      xdg.configFile."ai/docs-standards" = {
        source = ./content;
        recursive = true;
        force = true;
      };
    };
}
