{ config, lib, pkgs, ... }:
{
  config.flake.modules.nixvim.obsidian = { pkgs, ... }:
  let
    workspaces = if pkgs.stdenv.isDarwin then [
      {
        name = "huron";
        path = "/Users/nshreve/Obsidian/huron";
        overrides = {
          notes_subdir = "notes";
          daily_notes.folder = "notes/daily";
        };
      }
    ] else [
      {
        name = "slipbox";
        path = "/home/n/Obsidian/slipbox";
        overrides = {
          notes_subdir = "notes";
          daily_notes.folder = "notes/daily";
        };
      }
    ];
  in
  {

    plugins.obsidian = {

      enable = true;

      settings = {

        completion.nvim_cmp = true;
        new_notes_location = "notes_subdir";
        legacy_commands = false;

        picker = {
          name = "telescope.nvim";
        };

        templates = {
          date_format = "%Y-%m-%d";
          time_format = "%H:%M";
          subdir = "templates/";
          substitutions = {
            date.__raw      = builtins.readFile ./_lua/subs/date.lua;
            time.__raw      = builtins.readFile ./_lua/subs/time.lua;
            title.__raw     = builtins.readFile ./_lua/subs/title.lua;
            title_date.__raw = builtins.readFile ./_lua/subs/title_date.lua;
            id.__raw        = builtins.readFile ./_lua/subs/id.lua;
            path.__raw      = builtins.readFile ./_lua/subs/path.lua;
          };
        };

        daily_notes = {
          alias_format = "%B %-d, %Y";
          template = "templates/daily.md";
          workdays_only = false;
        };

        checkbox.order = [ " " "x" "!" "~" ">" ];

        workspaces = workspaces;

        vim.ui.open = { __raw = ''
          function(url)
            vim.fn.jobstart({"zen", url})
          end
        ''; };

        frontmatter.func.__raw = ''
          function(note)
            local out = {
              id = note.id,
              title = note.title,
              aliases = note.aliases,
              tags = note.tags
            }

            -- `note.metadata` contains any manually added fields in the frontmatter
            -- here we ensure those fields are kept in the frontmatter on save
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
              for k, v in pairs(note.metadata) do
                out[k] = v
              end
            end

            return out
          end
        '';

      };

      luaConfig.post = builtins.readFile ./_lua/config.lua;

    };

  };
}
