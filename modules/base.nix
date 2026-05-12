{ config, ... }:
{
  config.flake.modules.nixvim.base = { lib, pkgs, ... }: {

    imports = with config.flake.modules.nixvim; [
      autocmds
      files
      keymaps
      opts
      plugins
    ];

    enableMan = true;
    withPython3 = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      fd
      fzf
      gcc
      git
      lsof
      ripgrep
    ];

    extraPython3Packages = p: with p; [
      ipykernel
      jupyter-client
      jupytext
      pandas
      numpy
      # plotly -> scikit-image -> imageio -> av (PyAV); av's pythonImportsCheckPhase
      # is SIGKILLed on Darwin due to macOS codesigning restrictions on FFmpeg dylibs
      (plotly.overridePythonAttrs (_: { nativeCheckInputs = []; doCheck = false; }))
    ];

    nixpkgs.config.allowUnfree = true;

  };
}
