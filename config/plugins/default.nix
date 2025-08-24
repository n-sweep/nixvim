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
    jupytext.enable = true;
    markdown-preview.enable = true;
    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
    otter.enable = true;
    which-key.enable = true;

    qmk = {
      enable = true;
      settings = {
        name = "";
        layout = [
          "x x x x x x x _ _ _ _ _ _ _ x x x x x x x"
          "x x x x x x x _ _ _ _ _ _ _ x x x x x x x"
          "x x x x x x x _ x x _ x x _ x x x x x x x"
          "x x x x x x _ _ _ x _ x _ _ _ x x x x x x"
          "x x x x x _ _ x x x _ x x x _ _ x x x x x"
        ];
        variant = "zmk";
      };
    };

  };

  extraPlugins = with pkgs.vimPlugins; [

    r-nvim
    quarto-nvim
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
    "plugin/tmux.lua".source = ./lua/tmux.lua;
    "plugin/vim-dadbod.lua".source = ./lua/vim-dadbod.lua;
  };

}
