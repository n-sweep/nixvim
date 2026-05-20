{ ... }:
{
  config.flake.modules.nixvim.mini = { pkgs, ... }: {

    extraPackages = with pkgs; [ git ];

    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        diff.enable = true;
        git.enable = true;
        icons.enable = true;
        statusline.enable = true;
      };
    };

  };
}
