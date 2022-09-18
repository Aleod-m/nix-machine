_: { config, ...}:
let
  cfg = de.keyboard.workman-p;
in {
  options = {
    de.workman-p.enable = mkEnableOption "workman-p keyboard layout."; 
  };

  config = mkIf cfg.enable {
    services.xserver = {
      extraLayouts.fr-workman-p = {
        description = "Fench variation of the workman-p layout";
        languages = [ "fr" ];
        symbolsFile = ./. + "/fr-workman-p.xkb";
      };
      xkbVariant = "fr-workman-p";
      xkbOptions = "caps:swapescape";
    };
  };
}
