{
  pkgs,
  lib,
  ...
}: {
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
    nvtopPackages.full

    zed-editor

    ## Game dev
    godot_4
    tiled
    gimp
    inkscape
    blender
    # trenchbroom

    ## Gaming
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
