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

  driver.nvidia.enable = true;
  # desktop environement setup.
  de = {
    # enable my keyboard layout.
    # keyboard.workman-p.enable = true;

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

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
    allowedTCPPortRanges = [ { from = 8000; to = 9000; } ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };
}
