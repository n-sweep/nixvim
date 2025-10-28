{ pkgs, ... }:
let

  r-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "r.nvim";
    version = "unstable";
    src = builtins.fetchGit {
      url = "https://github.com/R-nvim/R.nvim.git";
      ref = "main";
    };
    nvimSkipModules = [
      "r.roxygen"
      "r.format"
    ];
  };

  cmp-r = pkgs.vimUtils.buildVimPlugin {
    pname = "cmp-r";
    version = "unstable";
    doCheck = false;
    src = builtins.fetchGit {
      url = "https://github.com/R-nvim/cmp-r";
      ref = "main";
    };
  };


in
{

  imports = [
    ./cmp.nix
    ./harpoon.nix
    ./lsp.nix
    ./mini.nix
    ./oil.nix
    ./obsidian
    ./telescope.nix
    ./treesitter.nix
    ./undotree.nix
  ];

  plugins = {

    comment.enable = true;
    fidget.enable = true;
    fzf-lua.enable = true;
    jupytext.enable = true;
    markdown-preview.enable = true;
    nix-develop.enable = true;
    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
    otter.enable = true;
    which-key.enable = true;

    # try later
    # gitignore.enable = true;

  };

  extraPlugins = with pkgs.vimPlugins; [

    cmp-r
    quarto-nvim
    r-nvim
    tmux-nvim
    vim-dadbod
    vim-dadbod-ui
    vim-dadbod-completion
    vim-python-pep8-indent

    # colorschemes
    gruvbox-nvim
    kanagawa-nvim
    tokyonight-nvim

  ];

  extraFiles = {
    # nvim plugins
    "plugin/colorschemes.lua".source = ./lua/colorschemes.lua;
    "plugin/foundry.lua".source = ./lua/foundry.lua;
    "plugin/misc.lua".source = ./lua/misc.lua;
    "plugin/r-nvim.lua".source = ./lua/r-nvim.lua;
    "plugin/tmux.lua".source = ./lua/tmux.lua;
    "plugin/vim-dadbod.lua".source = ./lua/vim-dadbod.lua;
  };

}
