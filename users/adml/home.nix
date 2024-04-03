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
    "warsow"
  ];
  home.packages = with pkgs; [
    #--- Desktop deps. ---#
    # Bluetooth.
    blueman
    # Sound.
    helvum
    pavucontrol
    # Clip board.
    wl-clipboard
    # Screen and brightness.
    wlr-randr
    wl-gammactl
    wlsunset
    brightnessctl
    gnupg # Not setup yet.

    #--- Software. ---#
    tenacity
    vcv-rack
    spotify
    vlc
    evince
    tuxguitar
    vscode
    libreoffice
    discord

    #--- Command Line utilities. ---#
    bat
    pciutils
    zoxide
    zellij
    ripgrep
    fd
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
    steam-run
    prismlauncher
    warsow
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
