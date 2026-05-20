{ ... }:
{
  config.flake.modules.nixvim.autocmds = { ... }: {

    autoCmd = [

      {
        desc = "remove trailing whitespace on save";
        event = "BufWritePre";
        pattern = "*";
        callback = { __raw = ''---@diagnostic disable: miss-name
          function()
              if vim.bo.filetype ~= 'markdown' then
                  vim.cmd([[%s/\s\+$//e]])
              end
          end'';
        };
      }

      {
        desc = "mometarily highlight yanked text";
        event = "TextYankPost";
        pattern = "*";
        callback = { __raw = ''---@diagnostic disable: miss-name
          function()
              vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 80 })
          end'';
        };
      }

      {
        desc = "load changes on disk";
        event = [ "FocusGained" "BufEnter" "CursorHold" ];
        pattern = "*";
        command = "checktime";
      }

    ];

  };
}
