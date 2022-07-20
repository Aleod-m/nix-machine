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
    mkComputer = { name, userName, sysModules }:  
    let 
      sysMods = map (moduleName: ./modules/. + "/${moduleName}") sysModules; 
    in lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs self;};
      modules = [
        home-manager.nixosModules.home-manager
        (./. + "/hardware/${name}.nix")
        ./modules/nixdefaults
      ] ++ sysMods ;
    };
  in {
    homeManagerConfigurations = {
      adml = home-manager.lib.homeManagerConfiguration { 
        inherit system pkgs;
        username = "adml";
        homeDirectory = "/home/adml"; 
        configuration = import ./users/adml/home.nix;
      };
      AdrienDML = home-manager.lib.homeManagerConfiguration { 
        inherit system pkgs;
        username = "AdrienDML";
        homeDirectory = "/home/AdrienDML"; 
        configuration = import ./users/AdrienDML/home.nix;
      };
    };

    nixosConfigurations = {
      nixos-pc = mkComputer {
        name = "nixos-pc";
        userName = "adml";
        sysModules = [
          "workman"
          "sound"
          "ssh"
          "nvidia"
        ];
      };
    };
  };
}
