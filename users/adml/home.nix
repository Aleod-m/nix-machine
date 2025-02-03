{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  home.shells = {
    default = "nushell";
    enabled = ["bash" "nushell"];
  };

  home.packages = with pkgs; [
    #--- Desktop deps. ---#
    # Bluetooth.
    blueman
    # Sound.
    helvum
    pavucontrol
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
    gimp
    inkscape
    blender

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
      ignores = [".envrc" ".direnv" ".devenv"];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
