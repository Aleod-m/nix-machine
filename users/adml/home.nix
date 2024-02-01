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
    #--- Desktop deps. ---#
    # Logout screen.
    wlogout
    # Notif daemon.
    mako
    # Launcher.
    rofi-wayland
    # Bluetooth.
    blueman
    # Sound.
    playerctl
    pamixer
    pulseaudio
    pavucontrol
    # Clip board.
    wl-clipboard
    # Screen and brightness.
    wlr-randr
    wlsunset
    brightnessctl
    # Screen recording.
    slurp
    grim

    gnupg # Not setup yet.

    #--- Software. ---#
    tenacity
    vcv-rack
    spotify
    vlc
    evince
    helvum
    tuxguitar
    vscode

    wally-cli # needed for my kbd.

    libreoffice
    discord

    #--- Command Line utilities. ---#
    bat
    pciutils
    zoxide
    zellij
    ripgrep
    starship
    unzip
    wget
    nushell
    socat
    nvtop

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
  programs = {
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
