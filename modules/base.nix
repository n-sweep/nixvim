{ config, ... }:
{
  config.flake.modules.nixvim.base = { pkgs, ... }: {
    imports = with config.flake.modules.nixvim; [ oil harpoon ];

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

    globals = {
      mapleader = " ";
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
    };

    opts = {
      autoread = true;

      number = true;
      relativenumber = true;
      cursorline = true;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;

      conceallevel = 1;
      scrolloff = 1919;
      signcolumn = "yes";
      colorcolumn = "100";
      wrap = false;

      incsearch = true;
      inccommand = "split";
      mouse = "";
      errorbells = false;
      termguicolors = true;

      undofile = true;
      swapfile = false;
      backup = false;
    };

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

    # non-plugin keymaps
    keymaps = [

      { # ESC in normal mode turns off highlighting
        key = "<ESC>";
        action = ":nohl<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Remove search highlighting";
        };
      }

      { # toggle spell check
        key = "<F6>";
        action = ":set spell!<CR>";
        options = {
          silent = true;
          desc = "Set spell check";
        };
      }

      { # toggle line break
        key = "<F7>";
        action = ":set wrap! linebreak! breakindent!<CR>";
        options = {
          silent = true;
          desc = "Set line breaks";
        };
      }

      {
        key = "<leader>w";
        action = ":w<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Write file (:w)";
        };
      }

      {
        key = "<leader>qq";
        action = ":q<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Quit this buffer (:q)";
        };
      }

      {
        key = "<leader>qQ";
        action = ":qa<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Quit all (:qa)";
        };
      }

      {
        key = "<leader>QQ";
        action = ":qa!<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Force quit all (:qa!)";
        };
      }

      {
        key = "<leader>o";
        action = "o<ESC>";
        mode = "n";
        options = {
          silent = true;
          desc = "Newline below, remain in Normal mode";
        };
      }

      {
        key = "<leader>O";
        action = "O<ESC>";
        mode = "n";
        options = {
          silent = true;
          desc = "Newline above, remain in Normal mode";
        };
      }

      {
        key = "<leader>y";
        action = ''"+y'';
        mode = ["n" "v"];
        options = {
          silent = true;
          desc = "Yank selection to system clipboard";
        };
      }

      {
        key = "<leader>yy";
        action = ''"+yy'';
        mode = "n";
        options = {
          silent = true;
          desc = "Yank line to system clipboard";
        };
      }

      {
        key = "<leader>Y";
        action = ''"+Y'';
        mode = "n";
        options = {
          silent = true;
          desc = "Yank line to system clipboard";
        };
      }

      {
        key = "<leader>p";
        action = ''"+p'';
        mode = ["n" "v"];
        options = {
          silent = true;
          desc = "Paste from system clipboard";
        };
      }

      {
        key = "<leader>P";
        action = ''"+P'';
        mode = ["n" "v"];
        options = {
          silent = true;
          desc = "Paste from system clipboard (before cursor)";
        };
      }

      {
        key = "<F30>";
        action = "<C-Tab>";
        mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
        options.silent = true;
      }

      {
        key = "<F31>";
        action = "<S-Tab>";
        mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
        options.silent = true;
      }

      {
        key = "<F32>";
        action = "<M-Tab>";
        mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
        options.silent = true;
      }

      {
        key = "<F33>";
        action = "<C-Enter>";
        mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
        options.silent = true;
      }

      {
        key = "<F34>";
        action = "<S-Enter>";
        mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
        options.silent = true;
      }

      {
        key = "<F35>";
        action = "<M-Enter>";
        mode = [ "!" "" "c" "i" "l" "o" "s" "t" "v" "x" ];
        options.silent = true;
      }

    ];

    # mini
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

    # telescope
    plugins.telescope = {
      enable = true;

      settings = {

        defaults = {
          sorting_strategy = "ascending";
          vimgrep_arguments = [
            "rg"
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
            "--hidden"
            "--glob"
            "!**/.git/*"
          ];
        };

        pickers = {
          find_files = {
            hidden = true;
            find_command = [ "rg" "--files" "--hidden" "--glob" "!**/.git/*" ];
          };
        };

      };

      keymaps = {
        "<leader>sr" = { action = "resume";        options.desc = "Telescope Resume"; };
        "<leader>sf" = { action = "find_files";    options.desc = "Telescope Find Files"; };
        "<leader>sb" = { action = "buffers";        options.desc = "Telescope Buffers"; };
        "<leader>sg" = { action = "live_grep";      options.desc = "Telescope Live grep"; };
        "<leader>s*" = { action = "grep_string";    options.desc = "Telescope grep string under cursor"; };
        "<leader>sc" = { action = "commands";       options.desc = "Telescope vim Commands"; };
        "<leader>sC" = { action = "command_history"; options.desc = "Telescope vim Command History"; };
        "<leader>sh" = { action = "help_tags";      options.desc = "Telescope vim Help Tags"; };
        "<leader>sG" = { action = "git_files";      options.desc = "Telescope git Files"; };
        "<leader>ld" = { action = "lsp_definitions"; options.desc = "Telescope LSP Definitions"; };
        "<leader>lj" = { action = "jumplist";       options.desc = "Telescope jumplist"; };
      };

    };

    # undotree
    plugins.undotree.enable = true;

    # inline plugins
    plugins.comment.enable = true;
    plugins.fidget.enable = true;
    plugins.fzf-lua.enable = true;
    plugins.markdown-preview.enable = true;
    plugins.nix-develop.enable = true;
    plugins.nvim-autopairs.enable = true;
    plugins.nvim-surround.enable = true;
    plugins.which-key.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      tmux-nvim
      vim-python-pep8-indent
      gruvbox-nvim
      kanagawa-nvim
      tokyonight-nvim
    ];

    extraFiles = {
      "plugin/colorschemes.lua".source = ./_lua/colorschemes.lua;
      "plugin/misc.lua".source         = ./_lua/misc.lua;
      "plugin/tmux.lua".source         = ./_lua/tmux.lua;
    };



  };
}
