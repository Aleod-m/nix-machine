# NixOs pc hardware config
_: {
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  driver.nvidia.enable = true;
  # desktop environement setup.
  de = {
    # enable my keyboard layout.
    # keyboard.workman-p.enable = true;

    lightdm.enable = true;

    gnome = {
      enable = true;
      extentions = with pkgs.gnomeExtensions; [
        extension-list
        blur-my-shell
        workspaces-bar
        tray-icons-reloaded
      ];
    };

    hyprland.enable = true;

    # Default applications to use accross the system.
    applications = with pkgs; {
      terminal = kitty;
      browser = firefox;
      documentViewer = evince;
      mediaPlayer = vlc;
      textEditor = nano;
      emailClient = thunderbird;
      imageViewer = feh;
    };

    # keyboard = {
    #   enable = true;
    #   # custom = {
    #   #   enable = true;
    #   #   keyboards = {
    #   #     tkl = {
    #   #       name = "tkl";
    #   #       device = "/dev/input/by-id/usb-SONiX_USB_DEVICE-event-kbd";
    #   #       composeKey = "ralt";
    #   #       fallthrough = true;
    #   #       allowCommands = false;
    #   #       config = ./workman_tkl.kbd;
    #   #     };
    #   #     internal = {
    #   #       name = "internal";
    #   #       device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
    #   #       composeKey = "ralt";
    #   #       fallthrough = true;
    #   #       allowCommands = false;
    #   #       config = ./workman_laptop.kbd;
    #   #     };
    #   #   };
    #   # };
    # };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
    allowedTCPPortRanges = [
      {
        from = 8000;
        to = 9000;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };
}
