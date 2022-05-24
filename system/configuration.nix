# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, home-manager, ... }: {

  imports             = [ ./hardware-configuration.nix ];
  sound.enable        = true;
  system.stateVersion = "21.11";
  time.timeZone       = "Europe/Paris";
  i18n.defaultLocale  = "en_US.UTF-8";

  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  nix.package                = pkgs.nixFlakes;
  nix.extraOptions           = '' experimental-features = nix-command flakes '';
  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    systemd-boot.enable      = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName                         = "nixos-pc";
    networkmanager.enable            = true;
    resolvconf.dnsExtensionMechanism = false;
    firewall.enable                  = false;
    interfaces = {
      enp4s0.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
  };  

  console = {
    font   = "Lat2-Terminus16";
    keyMap = "fr";
  };


  services = {
    printing.enable = true;
    openssh.enable  = true;
    xserver = {
      enable                        = true;
      libinput.enable               = true;
      displayManager.lightdm.enable = true;
      layout                        = "fr";
      
      windowManager.awesome = {
        enable     = true;
        luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
        ];
      };

      extraLayouts.fr-workman-p ={
        description = "Fench variation on the workman-p layout";
        languages = [ "fr" ];
        symbolsFile = ./fr-workman-p.xkb;
      };
    };
    
    pipewire = {
      enable                = true;
      alsa.enable           = true;
      pulse.enable          = true;
      #media-session.package = pkgs.wireplumber;
    };
  };

  users.users.adml = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "video" "uinput" "networkmanager" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    curl
    nano
    kitty
    git
  ];

  programs.mtr.enable  = true;
  programs.gnupg.agent = {
    enable           = true;
    enableSSHSupport = true;
  };

}

