{ ... }: {

  plugins.codecompanion = {
    enable = true;

    settings = {
      opts = {
        log_level = "ERROR";
        send_code = true;
        use_default_actions = true;
        use_default_prompts = true;
      };

      strategies = {
        chat = {
          adapter = {
            name = "opencode";
            model = "GLM5";
          };
        };
        inline = {
          adapter = {
            name = "opencode";
            model = "GLM5";
          };
        };
        agent = {
          adapter = {
            name = "opencode";
            model = "GLM5";
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = [ "n" "v" ];
      key = "<C-a>";
      action = "<cmd>CodeCompanionActions<cr>";
      options = {
        noremap = true;
        silent = true;
        desc = "CodeCompanion Actions";
      };
    }
    {
      mode = [ "n" "v" ];
      key = "<LocalLeader>a";
      action = "<cmd>CodeCompanionChat Toggle<cr>";
      options = {
        noremap = true;
        silent = true;
        desc = "Toggle CodeCompanion Chat";
      };
    }
    {
      mode = "v";
      key = "ga";
      action = "<cmd>CodeCompanionChat Add<cr>";
      options = {
        noremap = true;
        silent = true;
        desc = "Add selection to CodeCompanion Chat";
      };
    }
  ];

  extraConfigLua = ''
    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])

    -- Configure CodeCompanion chat keymaps when a chat buffer is created
    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeCompanionChatCreated",
      callback = function(args)
        local bufnr = args.data.bufnr
        local chat = require("codecompanion").buf_get_chat(bufnr)
        if chat then
          for _, mode in ipairs({ "n", "i" }) do
            vim.keymap.set(mode, "<F33>", function()
              chat:submit()
            end, { buffer = bufnr, noremap = true, silent = true, desc = "Send message" })
          end
        end
      end,
    })
  '';
}
