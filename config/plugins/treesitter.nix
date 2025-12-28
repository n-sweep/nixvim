{ ... }: {

  plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      parser_install_dir = "~/.cache/nvim/parsers";
      ensure_installed = [
        # https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
        "bash"
        "c"
        "diff"
        "gitattributes"
        "gitcommit"
        "git_config"
        "gitignore"
        "git_rebase"
        "go"
        "json"
        "lua"
        "markdown"
        "markdown_inline"
        "nix"
        "python"
        "r"
        "rnoweb"
        "regex"
        "sql"
        "ssh_config"
        "tmux"
        "vhs"
        "vim"
        "vimdoc"
        "yaml"
      ];
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
