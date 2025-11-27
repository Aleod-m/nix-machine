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
      "float, title:^(Incrustation vidéo)$"
      "keepaspectratio, title:^(Incrustation vidéo)$"
      "pin, title:^(Incrustation vidéo)$"

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

      "float, initialTitle:^()$, class:thunderbird"
      "center, initialTitle:^()$, class:thunderbird"
      "center, initialTitle:^(Extension : (Gestionnaire de mots de passe Bitwarden) - Bitwarden — Mozilla Firefox)$"

      "float, title:Rofi"
      "center, title:Rofi"
      "dimaround, title:Rofi"

      "float, class:feh"
      "center, class:feh"
      "dimaround, title:Rofi"

      "bordercolor ${cyan} ... ${green} 90deg ${grey}, fullscreen:1"

      "float, class:file-roller"
      "fullscreen, title:wlogout"
      "float, title:wlogout"
      "fullscreen, title:wlogout"
    ];

    workspace = map mkworkspacerule (__genList (x: x + 1) 20);
  };
}
