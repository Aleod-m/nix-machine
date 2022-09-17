_: { config, lib, pkgs, ... }: with lib;
let
  cfg = config.de.sound;
in {

  options = {
    de.sound = {
      enable = mkEnableOption "sound";
      sound-applet = mkOption {
          type = type.nullOr types.pkg;
          description = "The gui to use for sound controls.";
          default = pkgs.pavucontrol;
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      pipewire = {
        enable                = true;
        alsa.enable           = true;
        pulse.enable          = true;
        jack.enable           = true;
        alsa.support32Bit     = true;
      };
    };
    environement.systemsPackage = mkIf [
      cfg.sound-applet
    ];
  };
}
