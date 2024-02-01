{...}: {
  xdg.configFile = {
    hypr = {
      source =
        ./hypr;
      recursive =
        true;
    };
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
