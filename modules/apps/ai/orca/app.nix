{ self, inputs, ... }: {
  flake.homeModules.orca =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      skillSource = pkgs.fetchFromGitHub {
        owner = "stablyai";
        repo = "orca";
        rev = "bc2f593ebba70a0ee6ff900129e4918f57b143aa";
        hash = "sha256-c3EDXamEOAww02MU2c0oZsoSwZkIP7syxvS3TVa6Kf4=";
      };
      skillNames = [
        "orca-cli"
        "orca-linear"
        "orchestration"
      ];
      canonicalSkills = lib.listToAttrs (
        map (name: {
          name = ".agents/skills/${name}";
          value = {
            source = skillSource + "/skills/${name}";
            force = true;
          };
        }) skillNames
      );
      agentSkillDirectories = [
        ".claude/skills"
        ".claude.1/skills"
        ".codex/skills"
        ".pi/agent/skills"
      ];
      agentSkillLinks = lib.listToAttrs (
        lib.concatMap (
          directory:
          map (name: {
            name = "${directory}/${name}";
            value = {
              source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.agents/skills/${name}";
              force = true;
            };
          }) skillNames
        ) agentSkillDirectories
      );
    in
    {
      imports = [
      ];

      home.file = canonicalSkills // agentSkillLinks;

      home.packages = [
        pkgs.xvfb
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.orca
      ];
    };
}
