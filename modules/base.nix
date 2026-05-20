{ config, ... }:
{
  config.flake.modules.nixvim.base = { lib, pkgs, ... }: {

    imports = with config.flake.modules.nixvim; [
      autocmds
      files
      keymaps
      opts
    ];

    enableMan = true;
    withPython3 = true;
    viAlias = true;
    vimAlias = true;

    nixpkgs.config.allowUnfree = true;

  };
}
