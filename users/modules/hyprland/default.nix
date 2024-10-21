{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./config/default.nix
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

  # Copy hyprland config.
  # xdg.configFile = {
  #   hypr = {
  #     source = ./hypr;
  #     recursive = true;
  #   };
  # };

  # Cursor.
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
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

  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = true;
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

          outer_color = "rgb(97e023)";
          inner_color = "rgb(191919)";
          font_color = "rgb(f6f6ee)";

          fade_on_empty = false;
          placeholder_text = ''Password...'';

          dots_spacing = 0.2;
          dots_center = true;
        }
        {
          monitor = "HDMI-A-2";

          size = "300, 50";

          outline_thickness = 1;

          outer_color = "rgb(97e023)";
          inner_color = "rgb(191919)";
          font_color = "rgb(f6f6ee)";

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
          color = "rgb(#f6f6ee)";

          position = "0, 150";

          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          font_size = 20;
          color = "rgb(f6f6ee)";

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
        color: #f6f6ee;
      }

      window {
      	background-color: #191919;
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
