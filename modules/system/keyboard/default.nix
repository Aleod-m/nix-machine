_: {
  config,
  lib,
  pkgs,
  ...
}: let
  l = lib;
  t = lib.types;
  cfg = config.de.keyboard;
in
  {
    options = {
      de.keyboard = {
        enable = l.mkEnableOption "keyboard configuration";
        workman-p.enable = l.mkEnableOption "workman-p keyboard layout.";
        layout = l.mkOption {
          type = t.str;
          description = "A string containing all the layouts to use separated by commas.";
          default = "us";
        };
        variant = l.mkOption {
          type = t.str;
          description = "A string containing all the variants to corresponding layouts separated by commas. If on of the layout don't use any variants leave it empty.";
          default = "";
        };
        options = l.mkOption {
          type = t.str;
          description = "A string with all the options to use separated by commas.";
          default = "";
        };
      };
      de.kmonad = {
        enable = l.mkEnableOption "";
      };
    };


    config = l.mkIf cfg.enable {
      services.xserver = {
        #   displayManager.sessionCommands = l.mkIf cfg.workman-p.enable "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${workman-p} $DISPLAY";
        layout = cfg.layout;
        xkbVariant = cfg.variant;
        xkbOptions = cfg.options;
      };
    };
  }
