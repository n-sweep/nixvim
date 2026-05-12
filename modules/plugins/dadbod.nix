{ ... }:
{
  config.flake.modules.nixvim.dadbod = { pkgs, ... }:
  {

    extraPlugins = with pkgs.vimPlugins; [
      vim-dadbod
      vim-dadbod-ui
      vim-dadbod-completion
    ];

    extraFiles = {
      "plugin/vim-dadbod.lua".source  = ./_lua/vim-dadbod.lua;
    };

  };
}
