{
  description = "AdrienDML nixos config";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-22.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { 
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, home-manager, self, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
          inputs.neovim-overlay.overlay
      ];
      config = { allowUnfree = true; };
    };
    mkComputer = {hardware, userName, modules, homeModules}: 
      let 
        mods = map (moduleName: ./modules/. + "/${moduleName}") modules; 
        homeMods = map (moduleName: ./modules/home/. + "/${moduleName}") homeModules; 
      in inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit system inputs pkgs hardware; };
        modules = [
          #Machine config
          hardware
          #User config
          (./. + "/users/${userName}")
          #Home manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."${userName}" = {
              imports = [ (./. + "/users/${userName}/home.nix") ] ++ homeMods;
            };
          }
        ] ++ mods;
      };
  in {
    # My machine config
    nixosConfigurations = {
      asus-laptop = mkComputer {
        hardware = ./hardware/asus-laptop.nix;
        userName = "AdrienDML";
        modules = [
          "nixdefaults" # allow unfree pkgs and flakes.
        ];
        homeModules = [ ];
      };
    };
  };
}
