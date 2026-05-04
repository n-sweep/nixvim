{ config, inputs, ... }:
{
  perSystem = { pkgs, system, ... }:
  let
    mods = config.flake.modules.nixvim;

    pkgs' = pkgs.extend (final: prev: {
      # disable obsidian dependency check; always fails on _fzf
      vimPlugins = prev.vimPlugins.extend (vfinal: vprev: {
        obsidian-nvim = vprev.obsidian-nvim.overrideAttrs (_: {
          doCheck = false;
        });
      });
    });

    nixvimLib = inputs.nixvim.lib.${system};
    nixvim'   = inputs.nixvim.legacyPackages.${system};

    nixvimModule = {
      pkgs   = pkgs';
      module = { imports = with mods; [ base ide data creative obsidian ]; };
      extraSpecialArgs = { pkgs = pkgs'; };
    };

    nvim = nixvim'.makeNixvimWithModule nixvimModule;

  in
  {
    packages.default = nvim;
    checks.default   = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
  };
}
