{
  programs.nixvim = [
    globals = {
      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
    };
    clipboard = {
      # Use system clipboard
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

    opts = {
      # faster Completions
      updatetime = 100;

      # Relative numbers on the side.
      relativenumber = true;
      number = true;

      # Don't close non visible buffers.
      hidden = true;
      autoread = true; # Relaod buffers automaticaly.
      swapfile = false;

      # Allow mouse.
      mouse = "a";

      splitbelow = true;
      splitright = true;

      undofile = true;

      # Search options.
      completeopt = ["menu" "menuone" "noselect"];
      incsearch = true;
      ignorecase = true;
      smartcase = true;
      gdefault = true;

      scrolloff = 15;
      
      # Tab options
      tabstop = 4; # Number of spaces a <Tab> in the text stands for.
      shiftwidth = 4; # Number of spaces used for each step of (auto)indent.
      expandtab = true; # Expand <Tab> to spaces in Insert mode .
      autoindent = true; # Do clever autoindenting.
      smartindent = true;

      signcolumn = "yes"; # Whether to show the signcolumn.
      colorcolumn = "80"; # Columns to highlight.
    };
  ];
}
