# Gnome desktop environement configuration.
_: { config, lib, pkgs, ... }: with lib; 
let
  cfg = config.de.gnome;
  apps = config.de.applications;
in {

  options.de.gnome = {
    enable = mkEnableOption "gnome";
    includeGnomeGames = mkOption {
        type = types.bool;
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

    environment.gnome.excludePackages = 
    let
      games = if (!cfg.includeGnomeGames) then with pkgs.gnome; [
        totem
        tali
        iagno
        hitori
        atomix
      ] else [];
      default-apps =  with pkgs.gnome; [
        (mkIf (apps.terminal != null) gnome-terminal)
        (mkIf (apps.browser != null) epiphany)
        (mkIf (apps.emailClient != null) geary)
        (mkIf (apps.documentViewer != null) evince)
        (mkIf (apps.mediaPlayer != null) totem)
        cheese
    ];
    in
    with pkgs; [
      gnome-photos
      gnome-tour
    ] ++ games
      ++ default-apps; 
  };
}
