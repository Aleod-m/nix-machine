{...}: {
  programs.nixvim = {
    options = {
      sh = "nu";
      # allow unlimited undos.
      undofile = true;
      mouse = "a";

      # Indentation at 4 space by default
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
      smartindent = true;

      # search options.
      completeopt = "menu;menuone;noselect";
      incsearch = true;
      ignorecase = true;
      smartcase = true;
      gdefault = true;

      # Relative Numbers on the side
      number = true;
      relativenumber = true;

      termguicolors = true;
      # Set scrolloff to see bellow easily.
      scrolloff = 15;
      # Folds
      foldmethod = "expr";
      foldexpr = "nvim_treesitter#foldexpr()";

      # ?
      scl = "yes";

    # Usefull options for reloading the buffers.
      autoread = true;
      # 1 sec without moving will triger CursorHold
      ut = 1000;
    };
  };
}
