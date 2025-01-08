{...}: let
  green = "rgb(97e023)";
  orange = "rgb(fa8419)";
  yellow = "rgb(dfd561)";
  purple = "rgb(9c64fe)";
  red = "rgb(f3005f)";
  cyan = "rgb(57d1ea)";
  blue = "rgb(0e6172)";
  grey = "rgb(929276)";
  white = "rgb(f6f6ee)";

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

      "bordercolor ${cyan} ... ${green} 90deg ${grey}, fullscreen:1"

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

    workspace = map mkworkspacerule (__genList (x: x + 1) 20);
  };
}
