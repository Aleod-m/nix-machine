{ pkgs, ... }:
let
bashrcExtra = (import ./bashrcExtra.nix { inherit pkgs; }).bashrcExtra;
in {
  home = {
    username = "AdrienDML";
    homeDirectory = "/home/AdrienDML";

    packages = with pkgs; [
      discord
      spotify
      graphviz
      bat
      exa
      zoxide
      ripgrep
      starship
      vscode
      unzip
      rar
      wget
      htop
      tuxguitar
      vlc
      evince
      obs-studio
      peek
      gimp
      inkscape
      blender
      minecraft
      gcc
      pavucontrol
      xorg.xbacklight
      xclip
      vcv-rack
    ];
  };

  programs = {
    home-manager.enable = true;
    starship = {
      enable = true;
    };

    git = {
      enable    = true;
      userName  = "AdrienDML";
      userEmail = "adriendml99@gmail.com";
      delta.enable = true;
      extraConfig = {
        init = {
          defaultBranch = "master";
        };
      };
    };

    neovim = {
      enable   = true;
      package = pkgs.neovim-nightly;
    };

#    services = {
#      network-manager-applet.enable = true;
#    };

#    xsession = {
#      enable = true;
#      initExtra = "setxkbmap fr-workman-p -option caps:swapescape";
#    };
  };

#  theme = {
#
#  };
#
#  keys = {
#    navigation = {
#      up       = "t";
#      left     = "h";
#      down     = "k";
#      right    = "l";
#      next     = "n";
#      previous = "p";
#      open     = "o";
#      close    = "q";
#    };
#
#    modifiers = {
#        system = "Super";
#        grab   = "Shift";
#        modify = "Ctrl";
#    };
#  };
}
