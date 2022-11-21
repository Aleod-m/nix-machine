{
  description = "AdrienDML nixos config";

  inputs = {
    nixpkgs-2205.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:Misterio77/nix-colors";
    home-manager = { 
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    prism.url = "github:PrismLauncher/PrismLauncher";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, ... } @ inputs:
  let
    system = "x86_64-linux";
  in {
    lib = import ./lib inputs;

    # Modules authored. 
    nixosModules = import ./modules/system inputs;
    homeModules = import ./modules/home inputs;

    devShells = {
      packages = with inputs.nixpkgs-unstable; [
        alejandra
        git
      ];
    };

    # Packages with the neovim-nightly overlay.
    pkgs.x86_64-linux = import inputs.nixpkgs {
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];
    };

    upkgs.x86_64-linux = import inputs.nixpkgs-unstable {
        inherit system;
        overlays = [
          inputs.neovim-nightly-overlay.overlay
          inputs.prism.overlay
        ];
    };

    homeConfigurations = 
    let 
      overlays = with inputs; [
        prism.overlay 
        neovim-nightly-overlay.overlay 
      ];
    in {
      adml = self.lib.mkUser {
        inherit system overlays;
        username = "adml";
        pkgs = inputs.nixpkgs-unstable;
      };
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
