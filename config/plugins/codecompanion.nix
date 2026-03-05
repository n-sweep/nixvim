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
  '';
}
