{ self, inputs, ... }: {
  flake.homeModules.pi =
    { config, pkgs, ... }:
    {
      imports = [
      ];

      home.packages = [
        pkgs.nodejs_latest
        (pkgs.symlinkJoin {
          name = "pi-coding-agent";
          buildInputs = [ pkgs.makeWrapper ];
          paths = [
            inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi
          ];
          postBuild = ''
            wrapProgram $out/bin/pi \
              --set NPM_CONFIG_PREFIX ${config.home.homeDirectory}/.pi/npm/ \
              --prefix PATH : ${
                pkgs.lib.makeBinPath [
                  pkgs.nodejs_latest
                ]
              }
          '';
        })
      ];
    };
}
