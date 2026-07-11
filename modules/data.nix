{ config, ... }:
{
  config.flake.modules.nixvim.data = { pkgs, ... }: {

    imports = with config.flake.modules.nixvim; [
      dadbod
      r-nvim
    ];

    extraPython3Packages = p: with p; [

      # foundry requirements
      ipykernel
      jupyter-client
      nbformat

      pandas
      numpy

      # plotly -> scikit-image -> imageio -> av (PyAV); av's pythonImportsCheckPhase
      # is SIGKILLed on Darwin due to macOS codesigning restrictions on FFmpeg dylibs
      (plotly.overridePythonAttrs (_: { nativeCheckInputs = []; doCheck = false; }))

    ];

    plugins = {
      otter.enable = true;
      quarto.enable = true;
    };

    extraFiles = {
      "plugin/foundry.lua".source = ./plugins/_lua/foundry.lua;
    };

  };
}
