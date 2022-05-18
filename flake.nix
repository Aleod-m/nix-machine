{
  description = "AdrienDML nixos config";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-21.11";
    # nixpkgs-unstable.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager = { 
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
