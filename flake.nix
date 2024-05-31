{
  description = "Aleod nixos config";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager={
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url  = "github:hyprwm/Hyprland?ref=v0.40.0&submodule=1";
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

  # Enable cachix substituers.
  nixConfig = {
    # Adapted From: https://github.com/divnix/digga/blob/main/examples/devos/flake.nix#L4
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    extra-experimental-features = "nix-command flakes";
  };
}
