{pkgs, ...} @ inputs: {
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
    nh
    inputs.agenix.packages.${system}.default
  ];
  services.printing.enable = true;

  xdg.portal.enable = true;
}
