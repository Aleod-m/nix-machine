{
  description = "Aleod nixos config";

  nixConfig = {
    # Adapted From: https://github.com/divnix/digga/blob/main/examples/devos/flake.nix#L4
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    extra-experimental-features = "nix-command flakes";
  };

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland?tag=v0.38.0";
    nvim-nightly.url = "github:nix-community/neovim-nightly-overlay?rev=9b2c33c7fa0287db93868d955e7b3d0da3837a57";
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
