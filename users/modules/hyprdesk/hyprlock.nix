{
  hyprlock,
  pkgs,
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
  programs.hyprlock = {
    enable = true;
    package = hyprlock.packages.${pkgs.system}.hyprlock;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
      };

      background = [
        {
          monitor = "";
          path = "~/.config/wallpapers/rocket.png";
        }
      ];

      input-field = [
        {
          monitor = "eDP-1";

          size = "300, 50";

          outline_thickness = 1;

          outer_color = green;
          inner_color = bg;
          font_color = white;

          fade_on_empty = false;
          placeholder_text = ''Password...'';

          dots_spacing = 0.2;
          dots_center = true;
        }
        {
          monitor = "HDMI-A-2";

          size = "300, 50";

          outline_thickness = 1;

          outer_color = green;
          inner_color = bg;
          font_color = white;

          fade_on_empty = false;

          placeholder_text = ''Password...'';

          dots_spacing = 0.2;
          dots_center = true;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 50;
          color = white;

          position = "0, 150";

          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          font_size = 20;
          color = white;

          position = "0, 50";

          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
