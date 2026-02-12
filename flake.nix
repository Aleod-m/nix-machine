{
  description = "Aleod nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		flake-parts.url = "github:hercules-ci/flake-parts";

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
  };

  outputs = {
    nixpkgs,
		flake-parts,
    ...
  } @ _inputs: let
    # My own lib.
    mlib = import ./lib _inputs;
		# Flake parts lib
		flib = flake-parts.lib;
    inputs = _inputs // {inherit mlib;};
  in flib.mkFlake { inherit inputs; } ({...}: {
		imports = [ 
			(flib.importApply ./shells/default.nix {})
		];
		systems = ["x86_64-linux"];
	  perSystem = {pkgs,...}: { formatter = pkgs.alejandra; };
    flake = {
      # System independent flake outputs.

      # Authored Modules.
      # Os modules
      nixosModules = mlib.mk.modules "nixos" ["nix"];
      # HomeManager modules
      homeManagerModules = mlib.mk.modules "hm" ["shells" "remoterc"];

      # Configurations.
      homeConfigurations = mlib.mk.users inputs [
        {
          username = "adml";
          modules = [
            "nvim"
            "hyprdesk"
            "starship"
            "bash"
            "shell-utils"
            "ghostty"
            "wallpapers"
            "tmux"
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
            "podman"
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
	});
}
