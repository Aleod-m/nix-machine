{
  pkgs,
  lib,
  zen-browser,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  home.shells = {
    default = "bash";
    enabled = ["bash" "nushell"];
  };

  home.packages = with pkgs; [
    #--- Desktop deps. ---#
    # Bluetooth.
    blueman
    # Sound.
    helvum
    pavucontrol
    chromium

    #--- Software. ---#
    tenacity
    #vcv-rack
    spotify
    vlc
    evince
    vscode
    libreoffice
    vencord
    protonmail-desktop

    #--- Command Line utilities. ---#
    pciutils
    zip
    unzip
    wget
    nvtopPackages.full

    ## Game dev
    blender

    ## Gaming
    itch
    steam
    steam-run
    prismlauncher
    signal-desktop

    qutebrowser
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

    git = {
      enable = true;
      settings = {
        user = {
          name = "AdrienDML";
          email = "adriendml99@gmail.com";
        };
      };
      ignores = [".envrc" ".direnv" ".devenv"];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
