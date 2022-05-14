{
  description = "AdrienDML nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      adml = home-manager.lib.homeManagerConfiguration { 
        inherit system pkgs;
        username = "adml";
        homeDirectory = "/home/adml"; 
        configuration = ./users/adml/home.nix;
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
