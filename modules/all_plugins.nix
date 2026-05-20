{ config, ... }:
{
  config.flake.modules.nixvim.all_plugins = { pkgs, ... }: {

    imports = with config.flake.modules.nixvim; [
      data
      ide
      obsidian
      tidal
    ];

  };
}
