{
  description = "AdrienDML nixos config";

  inputs = {
    nixpkgs-2205.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { 
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, ... } @ inputs:
  let
    system = "x86_64-linux";
  in {

    lib = import ./lib inputs;

    # Modules authored. 
    nixosModules = import ./modules/system inputs;
    homeModules = import ./modules/home inputs;

    # Packages with the neovim-nightly overlay.
    pakages.x86_64-linux = import inputs.nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];
    };

    homeConfigurations = {
      adml = self.lib.mkUser "adml" system inputs.nixpkgs-unstable;
    };

    nixosConfigurations = {
      nixos-pc = self.lib.mkComputer {
        inherit system;
        pkgs = inputs.nixpkgs-2205;
        name = "nixos-pc";
        users = [ "adml" ];
      };
    };
  };
}
