{
  pkgs,
  hyprlock,
  ...
}: let 
  bg = "rgb(191919)";
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
  imports = [
    ./config/default.nix
    ./mako/default.nix
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
    gtk.enable = true;
    x11.enable = true;
  };

  home.packages = with pkgs; [
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

  services.mako = {
    enable = true;
    layer = "overlay";
  };

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

  programs.wlogout = let
    bgImageSection = name: ''
      #${name} {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/${name}.png"));
      }
    '';
  in {
    enable = true;

    style = ''
      * {
        background: none;
        color: #${white};
      }

      window {
      	background-color: #${bg};
      }

      button {
        margin: 1rem;
        background-color: #474747;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border-radius: 8px;
      }

      button:focus, button:active, button:hover {
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .1), 0 0 rgba(0, 0, 0, .5);
        outline-style: none;
      }

      ${pkgs.lib.concatMapStringsSep "\n" bgImageSection [
        "lock"
        "logout"
        "suspend"
        "hibernate"
        "shutdown"
        "reboot"
      ]}
    '';
  };
}
