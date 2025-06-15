{
  pkgs,
  mlib,
  ...
}: let 
  bg = "191919";
  green  = "97e023";
  orange = "fa8419";
  yellow = "dfd561";
  purple = "9c64fe";
  red    = "f3005f";
  cyan   = "57d1ea";
  blue   = "0e6172";
  grey   = "929276";
  white  = "f6f6ee";
in {
  imports = mlib.import ./. [
    "hypr"
    "mako"
    "rofi"
    "hyprlock"
    "wlogout"
  ];
  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = ["--all"];
  };

  # Cursor.
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
    gtk = {
      enable = true;
    };
    x11.enable = true;
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.libsForQt5.breeze-qt5;
    };
  };

  home.packages = with pkgs; [
		# jq for interacting with hyprctl
		jq
    # Sound.
    playerctl
    pamixer
    pulseaudio
    # Screen and brightness.
    wlr-randr
    wlsunset
    brightnessctl
    # Screen shot utility.
    grimblast
  ];
}
