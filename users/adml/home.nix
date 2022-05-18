{ pkgs, ... }: {
  home.packages = with pkgs; [
    bat
    exa
    zoxide
    starship

    vscode

    unzip
    wget
    vlc
    htop
    
    gimp
    inkscape
  ];
  home.username = "adml";
  home.homeDirectory = "/home/adml";
  programs = {
    home-manager.enable = true;
    bash = {
      enable = true;
      shellAliases = import ./shellAliases.nix {inherit pkgs;};
      
    };
    git = {
      enable = true;
      userName = "AdrienDML";
      userEmail = "adriendml99@gmail.com";
    };
  };
}
