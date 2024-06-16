{pkgs, ...}: {
  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    firefox
    kitty
    evince
    vlc
    nano
    thunderbird
    feh
  ];

  xdg.portal.enable = true;

  system.stateVersion = "21.11";
}
