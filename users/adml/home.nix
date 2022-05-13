{ config, pkgs, ... }: {
  home.pkgs = with pkgs; [
    gnumake
    bison
    jdk8
    jdk18
    unzip
    wget
    gnupg
    vlc
    htop
    exa
    vscode
    gradle
    maven
    gcc
    gdb
    valgrind cachegrind
    inkscape
    firefox
    spotify
    discord
    python3
    rustup
    zoxide
    gimp
  ];
  home.username = "adml";
  home.homeDirectory = "/home/adml";
  home.stateVersion = "21.11";
  programs = {
    home-manager.enable = true;
    bash = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "AdrienDML";
      userEmail = "adriendml99@gmail.com";
    };
  };
}
