# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, home-manager, self, ... }: 
let 
nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
export __NV_PRIME_RENDER_OFFLOAD=1
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
exec -a "$0" "$@"
'';
in {

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


    hardware = {
        opengl.enable = true;
        nvidia.prime = {
            offload.enable = true;
            nvidiaBusId = "PCI:1:0:0";
            intelBusId = "PCI:0:2:0";
        };
    };
    services = {
        printing.enable = true;
        openssh.enable  = true;
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

            extraLayouts.fr-workman-p ={
                description = "Fench variation on the workman-p layout";
                languages = [ "fr" ];
                symbolsFile = "${self}/system/fr-workman-p.xkb";
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
        extraGroups = [ "wheel" "input" "video" "uinput" "networkmanager" ];
    };

    environment.systemPackages = with pkgs; [
        nvidia-offload 
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

