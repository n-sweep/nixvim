{ ... }:
{
  config.flake.modules.nixvim.treesitter = { config, pkgs, ... }: {

    # treesitter
    plugins.treesitter = {
      enable = true;

      languageRegister.json = "jsonc";

      # lua, vim, vimdoc, markdown, markdown_inline are bundled by neovim 0.12+
      # installing them via nixpkgs puts older parsers first in runtimepath,
      # overriding neovim's newer bundled parsers and breaking bundled queries
      grammarPackages = (with config.plugins.treesitter.package.builtGrammars; [
        bash
        c
        diff
        gitattributes
        gitcommit
        git_config
        gitignore
        git_rebase
        go
        json
        nix
        python
        r
        rnoweb
        regex
        sql
        ssh_config
        yaml
      ]) ++ [
        (pkgs.tree-sitter.buildGrammar {
          language = "tmux";
          version = "0.0.0+rev=0252ecd";
          src = pkgs.fetchFromGitHub {
            owner = "Freed-Wu";
            repo = "tree-sitter-tmux";
            rev = "0252ecd080016e45e6305ef1a943388f5ae2f4b4";
            hash = "sha256-8f78qYxqoiOAnl3HzEbF4Rci3rFy0SnELoU+QP7pUlk=";
          };
        })
      ];

      settings = {
        highlight.enable = true;
      };
    };

    plugins.treesitter-textobjects = {
      enable = true;
      settings.select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
        };
      };
    };

  };
}
