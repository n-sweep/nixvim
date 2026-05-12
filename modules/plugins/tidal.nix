{ ... }:
{
  config.flake.modules.nixvim.tidal = { pkgs, ... }:
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

  };
}
