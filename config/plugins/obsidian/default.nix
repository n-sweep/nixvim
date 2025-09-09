{ ... }:
let
  obs_dir = "/home/n/Obsidian";
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

      note_frontmatter_func = { __raw = ''
        function(note)
            local out = {
              id = note.id,
              title = note.title,
              aliases = note.aliases,
              tags = note.tags
            }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
              for k, v in pairs(note.metadata) do
                out[k] = v
              end
            end

            return out
          end
      ''; };

      templates = {

        date_format = "%Y-%m-%d";
        subdir = "templates/";

      };

      daily_notes = {
        alias_format = "%B %-d, %Y";
        template = "templates/daily.md";
        workdays_only = false;
      };

      workspaces = [

        {
          name = "slipbox";
          path = "${obs_dir}/slipbox";
          overrides = {
            notes_subdir = "notes";
            daily_notes.folder = "notes/daily";
          };
        }

      ];

    };

    luaConfig.post = builtins.readFile ./config.lua;

  };

}
