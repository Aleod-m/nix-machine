# This m odule 
_: { config, lib, pkgs, ... }: with lib;
let
  cfg = config.de;
  apps = config.de.applications;
  captur = pkgs.writeShellScriptBin "capture" ''grim -g "$(slurp)"'';
in {
  options = {
    de = {
      displayProtocol = mkOption {
        type = types.enum [ "x11" "wayland" "" ];
        description = "The display protocol to use and the method. Enabling this options add utilities to the environment depending on wether x11 and/or wayland is set.";
        default = "";
      };

      disableDefaultApplications = mkOption {
          type = types.bool;
          description = "Wether to not include the default applications.";
          default = false;
      };

      applications = {
        terminal = mkOption {
            type = types.nullOr types.package;
            description = ''The terminal emulator to use.'';
            default = null;
        };
        browser = mkOption {
            type = types.nullOr types.package;
            description = ''The browser to use.'';
            default = null;
        };
        documentViewer = mkOption {
            type = types.nullOr types.package;
            description = ''The document viewer to use.'';
            default = null;
        };
        mediaReader = mkOption {
            type = types.nullOr types.package;
            description = ''The media reader to use'';
            default = null;
        };
        textEditor = mkOption {
            type = types.nullOr types.package;
            description = ''The text editor to use.'';
            default = null;
        };
        emailClient = mkOption {
            type = types.nullOr types.package;
            description = ''The email client to use'';
            default = null;
        };
        imageViewer = mkOption {
            type = types.nullOr types.package;
            description = ''The image viewer to use'';
            default = null;
        };
        fileExplorer = mkOption {
            type = types.nullOr types.package;
            description = ''The file explorer to use'';
            default = null;
        };
      };
    };
  };

  config = mkIf (!cfg.disableDefaultApplications) (mkMerge [
    {
      de.sound.enable = true;
      services.printing.enable = true;
      services.xserver.libinput.enable = true;
      environment.systemPackages = [
        (mkIf (apps.terminal != null) apps.terminal)
        (mkIf (apps.browser != null) apps.browser)
        (mkIf (apps.documentViewer != null) apps.documentViewer)
        (mkIf (apps.mediaReader != null) apps.mediaReader)
        (mkIf (apps.textEditor != null) apps.textEditor)
        (mkIf (apps.emailClient != null) apps.emailClient)
        (mkIf (apps.imageViewer != null) apps.imageViewer)
        (mkIf (apps.fileExplorer != null) apps.fileExplorer)
      ];
    }
    (mkIf (cfg.displayProtocol == "x11") {
      services.xserver.enable = true;
      environment.systemPackages = with pkgs; [
        xorg.xbacklight
        xclip
        xorg.xwd
        xorg.x11perf
        xorg.xsm
        xorg.xset
        xorg.xfd
        xorg.xev
        xorg.xkill
        xorg.xinit
        xorg.xrandr
        xorg.xmodmap
        xorg.xkbcomp
        xorg.xcbutil
        xorg.xgamma
        xorg.xbitmaps
        xorg.xkbutils
        xorg.xkbprint
      ];
    })
    (mkIf (cfg.displayProtocol == "wayland") {
      environment.systemPackages = with pkgs; [
        captur
        grim
        slurp
        wl-clipboard
      ];
    })
  ]);
} 
