{
  description = "Aleod nixos config";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland?tag=v0.35.0";
    #nixvim = {
    #  url = "path:./nixvim";
    #  inputs = {
    #    nixpkgs.follows = "nixpkgs";
    #    flake-utils.follows = "flake-utils";
    #  };
    #};
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs: let
    generic = flake-utils.lib.eachDefaultSystem (system: 
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells = import ./shells pkgs;

        formatter = pkgs.alejandra;

        # I output my nix vim config as i can run it on any systems
        # with nix installed with the command `nix run github:Aleod-m/nix-machine#nixvim`
        #packages = {
        #  nixvim = nixvim.packages.${system}.nixvim;
        #};

      });
  in generic // {
    inherit (import ./modules) nixosModules homeManagerModules mixedModules;

    # Extend nixpkgs library.
    lib = import ./lib nixpkgs;

    homeConfigurations = import ./users inputs;

    nixosConfigurations = import ./machines inputs;
  };
}
