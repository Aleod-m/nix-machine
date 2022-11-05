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
      "steam"
      "steam-original"
    ];

    home.packages = with pkgs; [
      wezterm
      helix
      discord
      steam
      spotify
      graphviz
      bat
      exa
      zoxide
      neovim
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

    #home.keyboard = null;

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
        ignores = [".envrc" ".direnv"];
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    services = {
      network-manager-applet.enable = true;
    };

    xsession = {
      enable = true;
    };
    xdg = {
      configFile = {
        nvim = {
          source = ./config/nvim;
          recursive = true;
        };
        devshells = {
          source = ./config/devshells;
          recursive = true;
        };
      };
    };
  };
}
