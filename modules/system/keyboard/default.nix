_: { config, lib, ...}:
let
  cfg = config.de.keyboard;
in with lib; {
  options = {
    de.keyboard = {
      enable = mkEnableOption "keyboard configuration";
      workman-p.enable = mkEnableOption "workman-p keyboard layout."; 
      layout = mkOption {
        type = types.str;
        description = "A string containing all the layouts to use separated by commas.";
      };
      variant = mkOption {
          type = types.str;
        description = "A string containing all the variants to corresponding layouts separated by commas. If on of the layout don't use any variants leave it empty.";
      };
      options = mkOption {
        type = types.str;
        description = "A string with all the options to use separated by commas."
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      extraLayouts.fr-workman-p = mkIf cfg.workman-p.enable {
        description = "Fench variation of the workman-p layout";
        languages = [ "fr" ];
        symbolsFile = ./. + "/fr-workman-p.xkb";
      };
      layout = cfg.layout;
      xkbVariant = cfg.variant;
      xkbOptions = cfg.options;
    };
  };
}
