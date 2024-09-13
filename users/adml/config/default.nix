{...}: {
  xdg.configFile = {
    kitty = {
      source = ./kitty;
      recursive = true;
    };
    wallpapers = {
      source = ./wallpapers;
    };
  };
}
