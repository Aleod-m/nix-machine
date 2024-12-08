{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowedUnfree = true;

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
    chromium

    #--- Software. ---#
    tenacity
#vcv-rack
    spotify
    vlc
    evince
    tuxguitar
    vscode
    libreoffice
    onlyoffice-bin
    discord
    webcord
    protonmail-desktop

    #--- Command Line utilities. ---#
    bat
    pciutils
    zoxide
    zellij
    ripgrep
    fd
    starship
    zip
    unzip
    wget
    socat
    nvtopPackages.full

    zed-editor

    ## Game dev
    unityhub
    godot_4
    tiled
    gimp
    inkscape
    blender
    # trenchbroom

    ## Gaming
    itch
    steam
    steam-run
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
