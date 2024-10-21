{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
    pciutils
    zoxide
    tmux
    ripgrep
    zip
    unzip
    wget
    socat
    libreoffice
    onlyoffice-bin
    bitwarden-cli
    bitwarden-desktop
    openvpn
    thunderbird
    seafile-client
    rocketchat-desktop
  ];

  programs = {
    htop.enable = true;
    starship.enable = true;
    git = {
      enable = true;
      userName = "Adrien Derobert-Mazure";
      userEmail = "adrien.derobertmazure@biblibre.com";
      ignores = [".envrc" ".direnv"];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
