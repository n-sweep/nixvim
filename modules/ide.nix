{ config, ... }:
{
  config.flake.modules.nixvim.ide = { pkgs, ... }: {

    imports = with config.flake.modules.nixvim; [
      cmp
      harpoon
      lsp
      mini
      oil
      qmk
      telescope
      treesitter
      undotree
    ];

    plugins = {

      comment.enable = true;
      fidget.enable = true;
      markdown-preview.enable = true;
      nvim-autopairs.enable = true;
      nvim-surround.enable = true;
      which-key.enable = true;

    };

    extraPlugins = with pkgs.vimPlugins; [
      tmux-nvim
      vim-python-pep8-indent
      gruvbox-nvim
      kanagawa-nvim
      tokyonight-nvim
    ];

    extraFiles = {
      "plugin/colorschemes.lua".source = ./plugins/_lua/colorschemes.lua;
      "plugin/misc.lua".source         = ./plugins/_lua/misc.lua;
      "plugin/tmux.lua".source         = ./plugins/_lua/tmux.lua;
    };

  };
}
