{
  description = "Aleod nixos config";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs: let
    generic = flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells = import ./shells pkgs;

      formatter = pkgs.alejandra;
    });
  in
    generic
    // {
      inherit (import ./modules) nixosModules homeManagerModules mixedModules;

      # Extend nixpkgs library.
      lib = import ./lib nixpkgs;

      homeConfigurations = import ./users inputs;

      nixosConfigurations = import ./machines inputs;
    };
}
