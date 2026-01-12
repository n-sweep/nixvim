{ ... }: {

  plugins.snacks.enable = true;
  plugins.opencode = {
    enable = true;
    settings = {
      input.enabled = true;
      autoread = true;
      provider = {
        enabled = "tmux";
      };
    };
  };

  keymaps = [

    {
      mode = [ "n" "x" ];
      key = "<M-a>";
      action.__raw = ''function() require('opencode').ask("@this: ", { submit = true }) end'';
      options = {
        desc = "Ask Opencode";
      };
    }

    {
      mode = [ "n" "x" ];
      key = "<M-x>";
      action.__raw = ''function() require('opencode').select() end'';
      options = {
        desc = "Execute Opencode Action";
      };
    }

    {
      mode = [ "n" "x" ];
      key = "<M-.>";
      action.__raw = ''function() require('opencode').toggle() end'';
      options = {
        desc = "Toggle Opencode";
      };
    }

    {
      mode = [ "n" "x" ];
      key = "go";
      action.__raw = ''function() return require('opencode').operator("@this ") end'';
      options = {
        desc = "Add Range to Opencode";
        expr = true;
      };
    }

    {
      mode = "n";
      key = "goo";
      action.__raw = ''function() return require('opencode').operator("@this ") .. "_" end'';
      options = {
        desc = "Add Line to Opencode";
        expr = true;
      };
    }

    {
      mode = [ "n" "x" ];
      key = "<C-M-u>";
      action.__raw = ''function() require('opencode').command("session.half.page.up") end'';
      options = {
        desc = "Opencode Half Page Up";
      };
    }

    {
      mode = [ "n" "x" ];
      key = "<C-M-d>";
      action.__raw = ''function() require('opencode').command("session.half.page.down") end'';
      options = {
        desc = "Opencode Half Page Down";
      };
    }

  ];

}
