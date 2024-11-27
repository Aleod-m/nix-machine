{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  home.shells = {
    default = "bash";
    enabled = ["bash" "nushell"];
  };

  home.packages = with pkgs; [
    spotify
    bat
    pciutils
    zoxide
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
    vscode
  ];

  programs = {
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      remoterc = {
        enable = true;
        text = __readFile ../modules/bash/extra.sh;
      };
    };
    tmate = {
      host = "tmate.biblibre.com";
      port = 2223;
      rsaFingerprint = "SHA256:HSH4PfoThYNtkrRZ7Zyw9HXkITkhT/ZksmFf2nZX/Ag";
      dsaFingerprint = "SHA256:62b9/JSA1j1yisZkbFvK2Uk/BG/uQQpws6FDY6iFCfc";
    };
    htop.enable = true;
    git = {
      enable = true;
      userName = "Adrien Derobert-Mazure";
      userEmail = "adrien.derobertmazure@biblibre.com";
      ignores = [".envrc" ".direnv"];
    };
  };
}
