{pkgs, ...}: {
  home.packages = with pkgs; [
    ghostty
  ];
  xdg.configFile = {
    ghostty = {
      source = ./conf;
      recursive = true;
    };
  };
}
