{ config, ... }:
{
  config.flake.modules.nixvim.ide = { pkgs, ... }: {

    imports = with config.flake.modules.nixvim; [
      cmp
      colorschemes
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
    ];

    extraFiles = {
      "plugin/misc.lua".source         = ./plugins/_lua/misc.lua;
      "plugin/tmux.lua".source         = ./plugins/_lua/tmux.lua;
    };

  };
}
