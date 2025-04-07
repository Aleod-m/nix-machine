{
  config,
  pkgs,
  system,
  lib,
  ...
} @ inputs: 
let 
  configDir = if pkgs.stdenv.isDarwin && !config.xdg.enable then
    "Library/Application Support/nushell"
  else
    "${config.xdg.configHome}/nushell";
in {
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
