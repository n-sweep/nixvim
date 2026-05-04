{ config, inputs, ... }:
{
  perSystem = { pkgs, system, ... }:
  let
    mods = config.flake.modules.nixvim;

    nixvimLib = inputs.nixvim.lib.${system};
    nixvim'   = inputs.nixvim.legacyPackages.${system};

    nixvimModule = {
      pkgs   = pkgs;
      module = { imports = with mods; [ base ide ]; };
      extraSpecialArgs = { inherit pkgs; };
    };

    nvim = nixvim'.makeNixvimWithModule nixvimModule;

  in
  {
    packages.light = nvim;
    checks.light   = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
  };
}
