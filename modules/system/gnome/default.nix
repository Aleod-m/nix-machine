# Gnome desktop environement configuration.
_: { config, lib, pkgs, ... }: with lib; 
let
  cfg = config.de.gnome;
  apps = config.de.applications;
in {

  options.de.gnome = {
    enable = mkEnableOption "gnome";
    includeGnomeGames = mkOption {
        type = types.boolean;
        description = ''If the games gnome provides should be included. By default they are not.'';
        default = false;
    };
    extentions = mkOption {
        type = types.listOf types.packages;
        description = ''List of gnome extentions to install'';
        default = [];
    };
  };

  config = mkIf cfg.enable {
    services = {
      xserver.desktopManager.gnome.enable = true;
    };

    environement.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ mkIf (!cfg.includeGnomeGames) (with pkgs.gnome;[
      cheese
      totem
      tali
      iagno
      hitori
      atomix
    ]) ++ (with pkgs.gnome;[
      (mkIf (apps.terminal != null) gnome-teminal)
      (mkIf (apps.browser != null) epiphany)
      (mkIf (apps.emailClient != null) geary)
      (mkIf (apps.documentViewer != null) evince)
      (mkIf (apps.mediaPlayer != null) totem)
    ]); 
  };
}
