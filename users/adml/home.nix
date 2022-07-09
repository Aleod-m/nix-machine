{ pkgs, ... }:
let
bashrcExtra = (import ./bashrcExtra.nix { inherit pkgs; }).bashrcExtra;
in {
    home = {
        username = "adml";
        homeDirectory = "/home/adml";
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
        #bash = {
        #    enable       = true;
        #    shellAliases = import ./shellAliases.nix {inherit pkgs;};
        #    inherit bashrcExtra;
        #};

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
            package  = pkgs.neovim-nightly;
            withRuby = false;

        };
    };

    services = {
        network-manager-applet.enable = true;
    };

    xsession = {
        enable = true;
        initExtra = "setxkbmap fr-workman-p -option caps:swapescape";
    };
}
