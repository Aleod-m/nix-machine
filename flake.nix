{
  description = "AdrienDML nixos config";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-22.05";
    home-manager = { 
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, home-manager, self, ... }@inputs:
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

    mkComputer = { name, users, sysModules }:  
    let 
      sysMods = map (moduleName: ./modules/. + "/${moduleName}") sysModules; 
      userMods = map (name: ./. + "/users/${name}") users;
    in lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs self;};
      modules = [
        home-manager.nixosModules.home-manager
        ./modules/nixdefaults
        (./. + "/hardware/${name}.nix")
      ] ++ sysMods ++ userMods;
    };

    mkUser = userName: home-manager.lib.homeManagerConfiguration { 
        inherit system pkgs;
        username = userName;
        homeDirectory = "/home/${userName}"; 
        configuration = import (./. + "/users/${userName}/home.nix");
    };

  in {
    homeManagerConfigurations = {
      adml = mkUser "adml";
      AdrienDML = mkUser "AdrienDML";
    };

    nixosConfigurations = {
      nixos-pc = mkComputer {
        name = "nixos-pc";
        users = [ "adml" "AdrienDML" ];
        sysModules = [
          "workman"
          "sound"
          "ssh"
          "bluetooth"
          "nvidia"
        ];
      };
    };
  };
}
