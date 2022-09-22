_: { config, lib, pkgs, ...}:
let
  cfg = config.de.keyboard;
  workman-p = pkgs.runCommand "keyboard-layout" {} ''
  ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${./. + "/workman-p.xkb"} $out
'';
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
        description = "A string with all the options to use separated by commas.";
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      displayManager.sessionCommands = mkIf cfg.workman-p.enable "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${workman-p} $DISPLAY";
      layout = cfg.layout;
      xkbVariant = cfg.variant;
      xkbOptions = cfg.options;
    };
  };
}
