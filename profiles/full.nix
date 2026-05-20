{ config, inputs, ... }:
{
  perSystem = { system, ... }:
  let
    mods    = config.flake.modules.nixvim;
    nixvimLib = inputs.nixvim.lib.${system};
    nixvim'   = inputs.nixvim.legacyPackages.${system};

    nixvimModule = {
      module = { imports = with mods; [
        all_plugins
        base
      ];};
    };

    nvim = nixvim'.makeNixvimWithModule nixvimModule;

  in
  {
    packages.default = nvim;
    checks.default   = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
  };
}
