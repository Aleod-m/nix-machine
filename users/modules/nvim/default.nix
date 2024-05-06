{pkgs, system, ... } @ inputs: {
  programs.neovim = {
    package = inputs.nvim-nightly.packages.${system}.default;
    enable = true;
    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
  };

  home.packages = with pkgs; [
    ripgrep
    fd
  ];

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
