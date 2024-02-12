{...}: {
  xdg.configFile = {
    nushell = {
      source =
        ./nushell;
      recursive =
        true;
    };
    kitty = {
      source =
        ./kitty;
      recursive =
        true;
    };
  };
}
