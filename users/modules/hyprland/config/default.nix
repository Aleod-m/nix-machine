{
  pkgs,
  config,
  ...
}: let
  green = "rgb(97e023)";
  orange = "rgb(fa8419)";
  yellow = "rgb(dfd561)";
  purple = "rgb(9c64fe)";
  red = "rgb(f3005f)";
  cyan = "rgb(57d1ea)";
  blue = "rgb(0e6172)";
  grey = "rgb(929276)";
  white = "rgb(f6f6ee)";

  pointer = config.home.pointerCursor;
  cursorName = "Bibata-Modern-Classic-Hyprcursor";
in {
  imports = [
    ./binds.nix
    ./rules.nix
  ];

  xdg.configFile = {
    hyprScripts = {
      target = "./hypr/scripts/";
      source = ./scripts;
      recursive = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$scripts" = "~/.config/hypr/scripts";
    monitor = [
      "eDP-1, preferred, 1920x0, 1"
      "HDMI-A-2, preferred, 0x0, 1"
    ];

    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "HYPRCURSOR_THEME,${cursorName}"
      "HYPRCURSOR_SIZE,${toString pointer.size}"
    ];
    xwayland.force_zero_scaling = true;

    exec-once = [
      # set cursor for HL itself
      "nu $scripts/swk.nu 1"
      "mako"
      "hyprctl setcursor ${cursorName} ${toString pointer.size}"
      "hyprlock"
    ];

    general = {
      border_size = 1;
      gaps_in = 2;
      gaps_out = 0;

      "col.active_border" = "${cyan} ${green} 90deg";
      "col.inactive_border" = grey;

      no_border_on_floating = true;
      layout = "master";
    };

    master = {
      mfact = 0.7;
      new_status = "slave";
      new_on_top = "true";
    };

    decoration = {
      rounding = 1;
      active_opacity = 1.0;

      blur = {
        enabled = true;
        size = 3;
        passes = 3;
        new_optimizations = true;
      };

      shadow.enabled = false;
    };

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      accel_profile = "flat";
      touchpad = {
        natural_scroll = "yes";
        disable_while_typing = "yes";
      };
    };

    cursor = {
      inactive_timeout = 1;
      hide_on_key_press = true;
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
      workspace_swipe_distance = 300;
      workspace_swipe_forever = true;
    };
    misc = {
      focus_on_activate = true;
    };

    animations.enabled = false;
  };
}
