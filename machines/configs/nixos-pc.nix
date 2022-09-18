# NixOs pc hardware config
_:
{ config, lib, pkgs, ... }: {

  time.timeZone       = "Europe/Paris";
  i18n.defaultLocale  = "en_US.UTF-8";

  fonts.fonts = with pkgs; [
      nerdfonts
  ];

  console = {
      font   = "Lat2-Terminus16";
      keyMap = "fr";
  };

  # desktop environement setup.
  de = {
    keyboard.workman-p.enable = true;

    lightdm.enable = true;

    gnome = {
      enable = true;
      extentions = with pkgs.gnomeExtensions; [
        pop-shell
        extension-list
        blur-my-shell
        clear-top-bar
        workspaces-bar
        tray-icons-reloaded

      ];
    };

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
  };
}
