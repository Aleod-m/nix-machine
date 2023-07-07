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
      "cudatoolkit"
    ];

    home.packages = with pkgs; [
      ## Desktop deps.
      playerctl
      wlogout
      eww-wayland
      mako
      waybar
      wlsunset
      rofi-wayland
      brightnessctl
      wl-clipboard
      wlr-randr
      blueman
      pamixer
      pulseaudio
      slurp
      grim
      ## others
      wally-cli
      nvtop
      fontforge-gtk
      fontforge
      tenacity
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
