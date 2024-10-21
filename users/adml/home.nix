{
  pkgs,
  lib,
  ...
}: {

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
    "cuda_cuobjdump"
    "cuda_gdb"
    "cuda_nvcc"
    "cuda_nvdisasm"
    "cuda_nvprune"
    "cuda_cccl"
    "cuda_cudart"
    "cuda_cupti"
    "cuda_cuxxfilt"
    "cuda_nvml_dev"
    "cuda_nvrtc"
    "cuda_nvtx"
    "cuda_profiler_api"
    "cuda_sanitizer_api"
    "libcublas"
    "libcufft"
    "libcurand"
    "libcusolver"
    "libnvjitlink"
    "libcusparse"
    "libnpp"
    "warsow"
    "unityhub"
  ];

  nixpkgs.config.allowlistedLicenses = with lib.licenses; [nvidiaCuda nvidiaCudaRedist];

  nixpkgs.config.permittedInsecurePackages = [
    "freeimage-unstable-2021-11-01"
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
    onlyoffice-bin
    discord
    webcord

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
