{ pkgs, ... } @ inputs: {
  time.timeZone = "Europe/Paris";

  users.defaultUserShell = pkgs.bash;

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    firefox
    ghostty
    evince
    vlc
    nano
    feh
    thunderbird
    nh
    inputs.agenix.packages.${system}.default
  ];

  services.printing.enable = true;

  xdg.portal.enable = true;
}
