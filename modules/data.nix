{ config, lib, pkgs, ... }:
{
  config.flake.modules.nixvim.data = { pkgs, ... }:
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

    extraPython3Packages = p: with p; [
      ipykernel
      jupyter-client
      jupytext
      pandas
      numpy
      plotly
    ];

    extraPlugins = with pkgs.vimPlugins; [
      r-nvim
      vim-dadbod
      vim-dadbod-ui
      vim-dadbod-completion
    ];

    nixpkgs.config.allowUnfree = true;

    plugins.jupytext.enable = true;
    plugins.otter.enable = true;
    plugins.quarto.enable = true;

    extraFiles = {
      "plugin/r-nvim.lua".source      = ./_lua/r-nvim.lua;
      "plugin/vim-dadbod.lua".source  = ./_lua/vim-dadbod.lua;
      "plugin/foundry.lua".source     = ./_lua/foundry.lua;
    };

  };
}
