{
  pkgs,
  system,
  ...
} @ inputs: {
  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
    ];
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
