{
  pkgs,
  system,
  ...
} @ inputs: {
  home.packages = with pkgs; [
    nushell
  ];

  xdg.configFile = {
    nushell = {
      source =
        ./config;
      recursive =
        true;
    };
  };
}
