# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, home-manager, self, ... }: {

    imports             = [ ./hardware-configuration.nix ];
    sound.enable        = true;
    system.stateVersion = "21.11";
    time.timeZone       = "Europe/Paris";
    i18n.defaultLocale  = "en_US.UTF-8";
    fonts.fonts = with pkgs; [
        nerdfonts
    ];
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


    hardware = {
        bluetooth.enable = true;
    };

    services = {
        printing.enable = true;
        openssh.enable  = true;
        picom = {
            enable = true;
        };
        blueman.enable = true;
        xserver = {
            enable                        = true;
            videoDrivers                  = [ "nvidia" ];
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
       };
        pipewire = {
            enable                = true;
            alsa.enable           = true;
            pulse.enable          = true;
            jack.enable           = true;
            alsa.support32Bit     = true;
        };
    };

    users.users.adml = {
        isNormalUser = true;
        shell = pkgs.nushell;
        extraGroups = [ "wheel" "input" "video" "uinput" "networkmanager" ];
    };

    users.users.AdrienDML = {
        isNormalUser = true;
        extraGroups = [ "wheel" "input" "video" "uinput" "networkmanager" ];
    };


    environment.systemPackages = with pkgs; [
            firefox
            xfce.thunar
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

