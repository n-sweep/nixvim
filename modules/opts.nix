{ ... }:
{
  config.flake.modules.nixvim.opts = { ... }: {

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

  };
}
