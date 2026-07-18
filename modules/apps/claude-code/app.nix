{ self, inputs, ... }: {
  flake.homeModules.claude-code =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.packages = with pkgs; [
        claude-code
      ];

      home.file.".claude/settings.json".source = ./settings.json;
      home.file.".claude/settings.json".force = true;
    };
}
