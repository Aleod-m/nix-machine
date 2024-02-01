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
  system.stateVersion = "21.11";
}
