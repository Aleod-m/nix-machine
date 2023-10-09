{
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
}
