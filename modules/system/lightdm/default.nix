# Gnome desktop environement configuration.
_: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.de.lightdm;
in {
  options.de.lightdm = {
    enable = mkEnableOption "lightdm";
  };

  config = mkIf cfg.enable {
    services = {
      xserver.displayManager.lightdm.enable = true;
      xserver.enable = true;
    };
  };
}
