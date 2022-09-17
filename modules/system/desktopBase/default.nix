# This m odule 
_: { config, lib, pkgs, ... }: with lib;
let
  cfg = config.de;
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
    };
  };

  config = mkIf (!cfg.disableDefaultApplications) (mkMerge [
    {
      de.sound.enable = true;
      services.printing.enable = true;
      services.xserver.libinput.enable = true;
      environment.systemPackages = with pkgs; [
        firefox
        curl
        nano
        kitty
        git
        peek
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
