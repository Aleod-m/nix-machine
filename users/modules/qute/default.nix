{...}: {
  xdg.configFile = {
    "qutebrowser" = {
      source = ./config;
			recursive = true;
    };
  };
}
