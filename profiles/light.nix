{ config, inputs, ... }:
{
  perSystem = { system, ... }:
  let
    mods    = config.flake.modules.nixvim;
    nixvimLib = inputs.nixvim.lib.${system};
    nixvim'   = inputs.nixvim.legacyPackages.${system};

    nixvimModule = {
      module = { imports = with mods; [ base ]; };
    };

    nvim = nixvim'.makeNixvimWithModule nixvimModule;

  in
  {
    packages.light = nvim;
    checks.light   = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
  };
}
