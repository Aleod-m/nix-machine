{...}: let
  mkworkspacerule = nb:
    if nb <= 10
    then "workspace=${toString nb}, monitor:DP-1"
    else "workspace=${toString nb}, monitor:HDMI-A-2";
in {
  wayland.windowManager.hyprland.settings = {
    # window rules
    windowrulev2 = [
      # make Firefox PiP window floating and sticky
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      "float, class:file_progress"
      "float, class:confirm"
      "float, class:dialog"
      "float, class:download"
      "float, class:notification"
      "float, class:error"
      "float, class:splash"
      "float, class:confirmreset"
      "float, title:Open File"
      "float, class:branchdialog"
      "float, title:^(Firefox - Sharing Indicator)$"

      "float, title:Rofi"
      "center, title:Rofi"
      "dimaround, title:Rofi"

      # "float, viewnior"
      "float, class:feh"
      "float, class:file-roller"
      "fullscreen, title:wlogout"
      "float, title:wlogout"
      "fullscreen, title:wlogout"
      "idleinhibit fullscreen, class:firefox"
      "float, title:^(Media viewer)$"
      "float, title:^(Picture-in-Picture)$"
    ];

    workspace = map mkworkspacerule [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
  };
}
