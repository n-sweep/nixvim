{ ... }:
{
  config.flake.modules.nixvim.ide = { config, pkgs, ... }: {

    # lsp
    plugins.lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        dockerls.enable = false;
        html.enable = false;
        jsonls.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        pyright.enable = true;
        sqls.enable = true;
        yamlls.enable = true;

        lua_ls = {
          enable = true;
          settings = {
            diagnostics = {
              globals = [ "vim" ];
            };
          };
        };

      };

      keymaps = {
        lspBuf = { "<leader>k" = "hover"; };
        diagnostic = {
          "<leader>ee" = "open_float";
          "<leader>en" = "goto_next";
          "<leader>eN" = "goto_prev";
        };
      };

    };

    # cmp
    plugins.cmp = {

      enable = true;
      autoEnableSources = true;

      settings = {

        mapping = {
          "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";

          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
        };

        sources = [
          { name = "buffer"; }
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "treesitter"; }
        ];

      };

    };

    # treesitter
    plugins.treesitter = {
      enable = true;

      # lua, vim, vimdoc, markdown, markdown_inline are bundled by neovim 0.12+
      # installing them via nixpkgs puts older parsers first in runtimepath,
      # overriding neovim's newer bundled parsers and breaking bundled queries
      grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
        bash
        c
        diff
        gitattributes
        gitcommit
        git_config
        gitignore
        git_rebase
        go
        json
        nix
        python
        r
        rnoweb
        regex
        sql
        ssh_config
        tmux
        yaml
      ];

      settings = {
        highlight.enable = true;
      };
    };

    extraConfigLua = ''
      vim.treesitter.language.register('json', 'jsonc')
    '';

    plugins.treesitter-textobjects = {
      enable = true;
      settings.select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
        };
      };
    };

    # codecompanion (disabled)
    # plugins.codecompanion = {
    #   enable = true;
    #   settings = {
    #     opts = {
    #       log_level = "ERROR";
    #       send_code = true;
    #       use_default_actions = true;
    #       use_default_prompts = true;
    #     };
    #     strategies = {
    #       chat   = { adapter = { name = "opencode"; model = "GLM5"; }; };
    #       inline = { adapter = { name = "opencode"; model = "GLM5"; }; };
    #       agent  = { adapter = { name = "opencode"; model = "GLM5"; }; };
    #     };
    #   };
    # };
    # keymaps for codecompanion (disabled)
    # { mode = ["n" "v"]; key = "<C-a>";         action = "<cmd>CodeCompanionActions<cr>";     options = { noremap = true; silent = true; desc = "CodeCompanion Actions"; }; }
    # { mode = ["n" "v"]; key = "<LocalLeader>a"; action = "<cmd>CodeCompanionChat Toggle<cr>"; options = { noremap = true; silent = true; desc = "Toggle CodeCompanion Chat"; }; }
    # { mode = "v";       key = "ga";             action = "<cmd>CodeCompanionChat Add<cr>";    options = { noremap = true; silent = true; desc = "Add selection to CodeCompanion Chat"; }; }

  };
}
