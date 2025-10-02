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
            "starship"
            "nushell"
            "kitty"
            "ghostty"
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
            "ghostty"
            "bash"
            "shell-utils"
            "tmux"
            "starship"
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
            "net"
            "nix"
            "ssh"
            "devices"
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
            "cosmic"
            "sound"
            "net"
            "graphics"
            "devices"
            "hyprland"
            "nix"
            "ssh"
            "docker"
            "lxd"
          ];
        }
      ];
    };
}
