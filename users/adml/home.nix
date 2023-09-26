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
      "aseprite"
    ];

    nixpkgs.config.permittedInsecurePackages = [
      "python-2.7.18.6" # needed for aseprite.
    ];
    
    home.packages = with pkgs; [
      ## Desktop deps.
      playerctl
      wlogout
      eww-wayland
      mako
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
      obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          input-overlay
          obs-pipewire-audio-capture
        ];
      };
      htop.enable = true;

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
        nushell = {
          source = ./config/nushell;
          recursive = true;
        };
      };
    };
  };
}
