{ pkgs, ... }: {
  home = {
    username = "adml";
    homeDirectory = "/home/adml";

    packages = with pkgs; [
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

      minecraft 
    ];
  };

  programs = {

    home-manager.enable = true;
    bash = {
      enable       = true;
      shellAliases = import ./shellAliases.nix {inherit pkgs;};
    };

    starship = {
      enable               = true;
    };
    
    git = {
      enable    = true;
      userName  = "AdrienDML";
      userEmail = "adriendml99@gmail.com";
    };

    neovim = {
      enable   = true;
      package  = pkgs.neovim-nightly;
      withRuby = false;
    };
  };
  
  services = {
    network-manager-applet.enable = true;
  };
}
