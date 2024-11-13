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
    ssh = {
        enable = true;
        addKeysToAgent = "ask 1h";
    };
    tmate = {
        enable = true;
        host = "tmate.biblibre.com";
        port = 2223;
        rsaFingerprint = "SHA256:HSH4PfoThYNtkrRZ7Zyw9HXkITkhT/ZksmFf2nZX/Ag";
        dsaFingerprint = "SHA256:62b9/JSA1j1yisZkbFvK2Uk/BG/uQQpws6FDY6iFCfc";
    };
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
