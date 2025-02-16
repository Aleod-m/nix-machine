{
  description = "Aleod nixos config";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For secret management.
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };

    # Desktop related.
    hyprland.url = "github:hyprwm/Hyprland";
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    self,
    ...
  } @ _inputs: let
    # Own lib.
    mlib = import ./lib _inputs;
    inputs = _inputs // {inherit mlib;};
  in
    # System dependent flake outputs.
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells = import ./shells pkgs;
        formatter = pkgs.alejandra;
      }
    )
    // {
      # System independent flake outputs.

      # Authored Modules.
      nixosModules = mlib.mk.modules "nixos" ["nix"];
      homeManagerModules = mlib.mk.modules "hm" ["shells" "remoterc"];

      # Configurations.
      homeConfigurations = mlib.mk.users inputs [
        {
          username = "adml";
          modules = [
            "nvim"
            "hyprdesk"
            "nushell"
            "kitty"
            "wallpapers"
          ];
        }
        {
          username = "adrien";
          modules = [
            "nvim"
            "hyprdesk"
            "nushell"
            "wallpapers"
            "kitty"
            "bash"
            "shell-utils"
            "tmux"
          ];
        }
      ];

      nixosConfigurations = mlib.mk.computers inputs [
        # My laptop (i know its caled pc but its a laptop that doesn't move much).
        {
          hostName = "nixos-pc";
          system = "x86_64-linux";
          users = ["adml"];
          modules = [
            "base"
            "sound"
            "ssh"
            "nix"
            "devices"
            "net"
            "nvidia"
            "hyprland"
            "docker"
            "tailscale"
          ];
        }
        {
          hostName = "nixos-dell";
          system = "x86_64-linux";
          users = ["adrien"];
          modules = [
            "base"
            "graphics"
            "sound"
            "hyprland"
            "gnome"
            "nix"
            "ssh"
            "docker"
            "devices"
          ];
        }
      ];
    };
}
