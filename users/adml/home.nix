_: {pkgs, ...}: let
  bashrcExtra = (import ./bashrcExtra.nix {inherit pkgs;}).bashrcExtra;
in {
  config = {
    nix.allowedUnfree = [
      "discord"
      "spotify"
      "spotify-unwrapped"
      "vscode"
      "vcv-rack"
      "steam"
      "steam-run"
      "steam-original"
      "obsidian"
    ];

    home.packages = with pkgs; [
      libreoffice
      bottles
      tiled
      pciutils
      gh
      obsidian
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
      godot
      python3
      xclip
      xorg.xbacklight
      xorg.xkbcomp
      prismlauncher
      emacs
      nushell
    ];

    programs = {
      home-manager.enable = true;
      obs-studio.enable = true;

      starship = {
        enable = true;
      };

      git = {
        enable = true;
        userName = "AdrienDML";
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
    # Non nix configfiles.
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
        nushell = {
          source = ./config/nushell;
          recursive = true;
        };
      };
    };
  };
}
