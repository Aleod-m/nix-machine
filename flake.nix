{
  description = "AdrienDML nixos config";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-21.11";
    home-manager = { 
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    overlays = [
      inputs.neovim-nightly-overlay.overlay
    ];
    pkgs = import nixpkgs {
      inherit system overlays;
      config = { allowUnfree = true; };
    };
    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      adml = home-manager.lib.homeManagerConfiguration { 
        inherit system pkgs;
        username = "adml";
        homeDirectory = "/home/adml"; 
        configuration = import ./users/adml/home.nix;
      };
    };

    nixosConfigurations = {
      nixos-pc = lib.nixosSystem {
        inherit system;
        modules = [ 
          home-manager.nixosModules.home-manager
          ./system/configuration.nix
        ];
      };
    };
  
  };
}
