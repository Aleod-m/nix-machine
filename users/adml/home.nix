{ pkgs, ... }: {
  home.packages = with pkgs; [
    discord
    spotify

    bat
    exa
    zoxide
    starship

    vscode

    unzip
    wget
    htop

    vlc
    obs-studio
    
    gimp
    inkscape

    multimc
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

  #services.xserver.layout = ;
}
