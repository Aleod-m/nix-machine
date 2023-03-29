-[{self, ...} @ inputs: 
{lib, ...}:
let
  l = self.lib;
  t = l.types;
  cfg = config.de.hyprland.config;

  general = {
    sensitivity = l.mkOption {
      type = t.float;
    };
    borderSize = l.mkOption {
      type = t.int;
      default = 1;
    };
    noBorderOnFloating = l.mkOption {
      type = t.bool;
      default = false;
    };
    gapsIn = {
      type = t.int;
      default = 5;
    };
    gapsOut = {
      type = t.int;
      default = 20;
    };
    col = {
      inactiveBorder = {
        type = t.color;
        default = false;
      };
      activeBorder = {};
    };
    cursorInactiveTimeout = {};
    layout = {};
    noCursorWraps = {};
    applySensToRaw = {};
  };

  decoration = {
    rounding = {};
    multisampleEdges = {};
    activeOpacity = {};
    blur = {
      enable = l.mkEnableOption "blur";
      size = l.mkOption {
        type = t.int;
        default = 8;
      };
      passes = l.mkOption {
        type = t.int;
        default = 1;
      };
      ignoreOpacity = l.mkOption {
        type = t.bool;
        default = false;
      };
      newOptimizations = l.mkOption {
        type = t.bool;
        default = true;
      };
      xray = l.mkOption {
        type = t.bool;
      };
    };
  };
in {
  options.de.hyprland.config = {

  };
  config = {

  };
}