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
in {
  wayland.windowManager.hyprland.settings = {
    # window rules
    windowrule = [
      # telegram media viewer
      "match:title ^Media viewer$, float on"

      # Bitwarden extension
      "match:title ^.*Bitwarden Password Manager.*$, float on, center on, border_color ${red}"

      "match:class com.mitchellh.ghostty, match:title ^~$, float on, center on"

      # make Firefox/Zen PiP window float oning and sticky
      "match:title ^(Picture-in-Picture)$, float on"
      "match:title ^(Picture-in-Picture)$, pin on"

      # throw sharing indicators away
      "match:title ^(Firefox — Sharing Indicator)$, workspace special silent"
      "match:title ^(Zen — Sharing Indicator)$, workspace special silent"
      "match:title ^(.*is sharing (your screen|a window)\.)$, workspace special silent"

      "match:class ^(xdg-desktop-portal-gtk)$, dim_around on"
      "match:title Rofi, dim_around on"
      "match:class feh, float on"
      "match:class feh, center on"

      "match:initial_title ^()$, match:class thunderbird, float on"
      "match:initial_title ^()$, match:class thunderbird, center on"

      # "bordercolor ${cyan} ... ${green} 90deg ${grey}, fullscreen:1"

      "match:class file-roller, float on"
      "match:title wlogout, fullscreen on"
      "match:title wlogout, float on"
      "match:title wlogout, fullscreen on"
    ];
  };
}
