{
  pkgs,
  mlib,
  ...
}: {
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

	services.hyprpolkitagent.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
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

  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk";
  #   style = {
  #     name = "gtk2";
  #     package = pkgs.libsForQt5.breeze-qt5;
  #   };
  # };

  home.packages = with pkgs; [
		hyprpwcenter
		# jq for interacting with hyprctl
		jq
    # Sound.
    playerctl
    # Screen and brightness.
    wlr-randr
    wlsunset
    brightnessctl
    # Screen shot utility.
    grimblast
  ];
}
