{ ... }:
{
  config.flake.modules.nixvim.colorschemes = { pkgs, ... }:
  {

    extraPlugins = with pkgs.vimPlugins; [
      base16-nvim
      gruvbox-nvim
      kanagawa-nvim
      tokyonight-nvim
    ];

    extraFiles."plugin/colorschemes.lua".source = ./_lua/colorschemes.lua;

  };
}
