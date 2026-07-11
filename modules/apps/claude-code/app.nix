{ self, inputs, ... }: {
  flake.homeModules.claude-code =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.packages = with pkgs; [
        claude-code
      ];
    };
}
