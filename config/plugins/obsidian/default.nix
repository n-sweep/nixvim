{ ... }: {

  plugins.obsidian = {

    enable = true;

    settings = {

      completion.nvim_cmp = true;
      new_notes_location = "notes_subdir";
      legacy_commands = false;

      follow_url_func = { __raw = ''
        function(url)
          vim.fn.jobstart({"zen", url})
        end
      ''; };

      templates = {

        date_format = "%Y-%m-%d";
        subdir = "/home/n/Obsidian/slipbox/templates";

        substitutions.title_date = { __raw = ''
          function()
            return os.date("%A, %B %d")
          end
        '';};

      };

      workspaces = [

        {
          name = "slipbox";
          path = "/home/n/Obsidian/slipbox";
          overrides = {
            notes_subdir = "notes";
            daily_notes = {
              folder = "notes/daily";
              template = "templates/daily.md";
            };
          };
        }

      ];

    };

    luaConfig.post = builtins.readFile ./config.lua;

  };

}
