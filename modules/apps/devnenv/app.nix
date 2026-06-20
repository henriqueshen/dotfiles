{ self, inputs, ... }: {
  flake.homeModules.devenv =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
      ];

      home.packages = [
        pkgs.devenv
      ];

      programs.bash = {
        enable = true;
        initExtra = ''
          eval "$(devenv hook bash)"
        '';
      };

      programs.zsh = {
        enable = true;
        initExtra = ''
          eval "$(devenv hook zsh)"
        '';
      };

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          devenv hook fish | source
        '';
      };
    };
}
