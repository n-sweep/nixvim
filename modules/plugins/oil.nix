{ ... }:
{
  config.flake.modules.nixvim.oil = { pkgs, ... }: {

    plugins.oil = {
      enable = true;
      settings.view_options.show_hidden = true;
    };

    keymaps = [
      {
        action = ":Oil<CR>";
        key = "-";
        mode = "n";
        options = {
          silent = true;
          desc = "Open Oil";
        };
      }
    ];

  };
}
