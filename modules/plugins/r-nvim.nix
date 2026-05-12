{ ... }:
{
  config.flake.modules.nixvim.r-nvim = { lib, pkgs, ... }:
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

    extraPlugins = [ r-nvim ];

    extraFiles = { "plugin/r-nvim.lua".source = ./_lua/r-nvim.lua; };

  };
}
