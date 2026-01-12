{ pkgs, ... }: {

  plugins.treesitter = {
    enable = true;

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
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
      lua
      markdown
      markdown_inline
      nix
      python
      r
      rnoweb
      regex
      sql
      ssh_config
      tmux
      vim
      vimdoc
      yaml
    ];

    settings = {
      highlight.enable = true;
      parser_install_dir = "~/.cache/nvim/parsers";
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

}
