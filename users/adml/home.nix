_: { pkgs, ... }:
let
  bashrcExtra = (import ./bashrcExtra.nix { inherit pkgs; }).bashrcExtra;
in { 
  config = {
    nix.allowedUnfree = [
      "discord"
      "spotify"
      "spotify-unwrapped"
      "vscode"
      "vcv-rack"
    ];

    home.packages = with pkgs; [
      discord
      steam
      spotify
      graphviz
      bat
      exa
      zoxide
      ripgrep
      starship
      vscode
      unzip
      wget
      htop
      tuxguitar
      vlc
      evince
      peek
      gimp
      inkscape
      blender
      gcc
      pavucontrol
      polymc
      godot
      python3
      xclip
      xorg.xbacklight
      xorg.xkbcomp
    ];

    home.keyboard = null;

    programs = {
      home-manager.enable = true;
      obs-studio.enable = true;

      bash = {
        enable       = true;
        shellAliases = import ./shellAliases.nix {inherit pkgs;};
        inherit bashrcExtra;
      };

      starship = {
        enable = true;
      };

      git = {
        enable    = true;
        userName  = "AdrienDML";
        userEmail = "adriendml99@gmail.com";
      };
      neovim = {
        enable   = true;
        #package  = pkgs.neovim-nightly;
        withRuby = false;
      };
    };
    services = {
      network-manager-applet.enable = true;
    };
    xsession = {
      enable = true;
    };
  };
}
