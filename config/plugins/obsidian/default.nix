{ ... }:
let
  obs_dir = "/home/n/Obsidian";
  templates_dir = "${obs_dir}/templates";
in
{

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
        subdir = templates_dir;

        substitutions.title_date = { __raw = ''
          function()
            return os.date("%A, %B %d")
          end
        '';};

      };

      workspaces = [

        {
          name = "slipbox";
          path = "${obs_dir}/slipbox";
          overrides = {
            notes_subdir = "notes";
            daily_notes = {
              folder = "notes/daily";
              template = "${templates_dir}/daily.md";
            };
          };
        }

      ];

    };

    luaConfig.post = builtins.readFile ./config.lua;

  };

}
