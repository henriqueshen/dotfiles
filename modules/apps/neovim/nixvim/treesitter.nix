{ self, inputs, ... }:
{
  flake.nixvimModules.treesitter =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      plugins.treesitter = {
        enable = true;

        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
        grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
          bash
          c
          css
          diff
          go
          gomod
          gotmpl
          gowork
          gosum
          graphql
          html
          javascript
          jsdoc
          json
          lua
          luadoc
          luap
          make
          markdown
          markdown_inline
          nix
          proto
          python
          query
          regex
          rust
          toml
          tsx
          typescript
          vim
          vimdoc
          xml
          yaml
        ];
      };
    };
}
