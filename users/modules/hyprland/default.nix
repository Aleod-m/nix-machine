{...}: {
  xdg.configFile = {
    hypr = {
      source = ./hypr;
      recursive = true;
    };
  };
  home.packages = with pkgs; [
    # Logout screen.
    wlogout
    # Notif daemon.
    mako
    # Launcher.
    rofi-wayland
    playerctl
    pamixer
    pulseaudio
    # Screen and brightness.
    wlr-randr
    wlsunset
    brightnessctl
    grimblast
  ];
}
