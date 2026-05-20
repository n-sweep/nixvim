{ ... }:
{
  config.flake.modules.nixvim.files = { ... }: {

    files = {

      "ftplugin/lua.lua" = {
        opts = {
          tabstop = 4;
          softtabstop = 4;
          shiftwidth = 4;
        };
      };

      "ftplugin/markdown.lua" = {
        opts = {
          wrap = true;
          linebreak = true;
          breakindent = true;
          conceallevel = 2;
        };
        keymaps = [

          {
            key = "k";
            action = "gk";
            mode = [ "n" "v" ];
            options = {
              silent = true;
              desc = "Go Up by Display Lines";
            };
          }

          {
            key = "j";
            action = "gj";
            mode = [ "n" "v" ];
            options = {
              silent = true;
              desc = "Go Down by Display Lines";
            };
          }

        ];
      };

      "ftplugin/nix.lua" = {
        opts = {
          tabstop = 2;
          softtabstop = 2;
          shiftwidth = 2;
        };
      };

      "ftplugin/R.lua" = {
        opts = {
          tabstop = 2;
          softtabstop = 2;
          shiftwidth = 2;
        };
      };

    };

  };
}
