{ pkgs, ... }: {
  home.pkgs = with pkgs; [
    gnumake
    bison
    jdk8
    jdk17
    maven
    unzip
    wget
    gnupg
    vlc
    htop
    exa
    zoxide
    vscode
    gradle
    gcc
    gdb
    inkscape
    firefox
    spotify
    discord
    python3
    rustup
    gimp
  ];
  home.username = "adml";
  home.homeDirectory = "/home/adml";
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
