{pkgs, ...}: {
  imports = [./config];
  nix.allowedUnfree = [
    "discord"
    "spotify"
    "spotify-unwrapped"
    "vscode"
    "vcv-rack"
    "steam"
    "steam-run"
    "steam-original"
    "VCV-Rack"
    "cudatoolkit"
  ];
  home.packages = with pkgs; [
    ## Desktop deps.
    eww-wayland
    # Logout screen.
    wlogout
    # Notif daemon.
    mako

    ## screen utilities.
    wlr-randr
    wlsunset
    brightnessctl

    wl-clipboard

    ## Sound utilities.
    playerctl
    blueman
    pamixer
    pulseaudio
    pavucontrol

    ## Screen shot utilities.
    slurp
    grim

    vlc
    evince
    helvum
    gnupg
    tuxguitar
    vscode

    rofi-wayland

    ## others
    wally-cli

    nvtop
    tenacity
    vcv-rack
    libreoffice
    discord
    spotify

    ## cli
    bat
    pciutils
    zoxide
    ripgrep
    starship
    unzip
    wget
    nushell
    socat
    neovim
    gcc # Needed by neovim

    ## Game dev
    godot_4
    tiled
    gimp
    inkscape
    blender

    ## Gaming
    steam
    prismlauncher
  ];
  programs =
    {
      # Home manager manages itself.
      home-manager.enable = true;
      obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          # Wayland plugin
          wlrobs
          input-overlay
          # Sound plugin
          obs-pipewire-audio-capture
        ];
      };
      htop.enable = true;
      starship.enable = true;
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
}
