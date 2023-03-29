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
      "VCV-Rack"
    ];

    home.packages = with pkgs; [
      socat
      vcv-rack
      libreoffice
      tiled
      pciutils
      gh
      obsidian
      discord
      steam
      spotify
      bat
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
      gimp
      inkscape
      blender
      gcc
      pavucontrol
      godot_4
      prismlauncher
      nushell
      jetbrains.idea-community
      rofi
      waybar
      wlogout
      eww-wayland
      dunst
      wlsunset
      brightnessctl
      wl-clipboard
      wlr-randr
      blueman
      pamixer
      pulseaudio
      slurp
      grim
      helvum
      gnupg
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
