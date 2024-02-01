{...}: {
  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
    withNodeJs= false;
  };
  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
