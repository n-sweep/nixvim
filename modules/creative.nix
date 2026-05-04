{ config, lib, pkgs, ... }:
{
  config.flake.modules.nixvim.creative = { pkgs, ... }:
  let
    vim-tidal = pkgs.vimUtils.buildVimPlugin {
      pname = "vim-tidal";
      version = "unstable";
      src = pkgs.fetchFromGitHub {
        owner = "tidalcycles";
        repo = "vim-tidal";
        rev = "e440fe5bdfe07f805e21e6872099685d38e8b761";
        hash = "sha256-8gyk17YLeKpLpz3LRtxiwbpsIbZka9bb63nK5/9IUoA=";
      };
    };
  in
  {

    extraPlugins = [ vim-tidal ];

    plugins.qmk = {
      enable = true;
      settings = {
        name = "adv360pro";
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
}
