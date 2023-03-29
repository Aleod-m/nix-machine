## This the base module that define the options for the color scheme of your system.
{self, ...}: 
{ lib, config, ...}:
let
  l = lib;
  t = l.types;
  cfg = config.themes;

  theme = {
    colors = l.mkOption {
      type = t.attrsOf t.color;
    };

    urgent = l.mkOption {
      type = t.either t.color t.str;
    };
    inactive = l.mkOption {
      type = t.either t.color t.str;
    };
    active = l.mkOption {
      type = t.either t.color t.str;
    };

    git = {
      added = l.mkOption {
        type = t.either t.color t.str;
      };
      modified = l.mkOption {
        type = t.either t.color t.str;
      };
      removed = l.mkOption {
        type = t.either t.color t.str;
      };
    };
  };
in {
  options.themes = {
    enable = l.mkEnableOption "themes.";

    active = l.mkOption {
      type = t.str;
    };
    
    themes = {
      type = t.listOf t.submodule theme;
    };
  };
}

