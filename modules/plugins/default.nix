{ config, ... }:
{
  config.flake.modules.nixvim.plugins = { pkgs, ... }: {

    imports = with config.flake.modules.nixvim; [
      cmp
      dadbod
      harpoon
      lsp
      mini
      obsidian
      oil
      qmk
      r-nvim
      telescope
      tidal
      treesitter
      undotree
    ];

    plugins = {
      comment.enable = true;
      fidget.enable = true;
      fzf-lua.enable = true;
      markdown-preview.enable = true;
      nix-develop.enable = true;
      nvim-autopairs.enable = true;
      nvim-surround.enable = true;
      which-key.enable = true;

      # data plugins
      jupytext.enable = true;
      otter.enable = true;
      quarto.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      tmux-nvim
      vim-python-pep8-indent
      gruvbox-nvim
      kanagawa-nvim
      tokyonight-nvim
    ];

    extraFiles = {
      "plugin/colorschemes.lua".source = ./_lua/colorschemes.lua;
      "plugin/misc.lua".source         = ./_lua/misc.lua;
      "plugin/tmux.lua".source         = ./_lua/tmux.lua;

      "plugin/foundry.lua".source     = ./_lua/foundry.lua;
    };

  };
}
