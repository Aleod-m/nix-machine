{
  description = "AdrienDML nixos config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    hyprland.url = "github:hyprwm/Hyprland?tag=v0.33.1";
  };
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    devPkgs = (import nixpkgs) {system = "x86_64-linux";};
  in {
    devShells.x86_64-linux.default = devPkgs.mkShell {
      packages = with devPkgs; [
        alejandra
        git
        rnix-lsp
        just
      ];
    };

    inherit
      (import ./modules)
      nixosModules
      homeManagerModules
      mixedModules
      ;

    formatter.x86_64-linux = devPkgs.alejandra;

    homeConfigurations = import ./users inputs;

    nixosConfigurations = import ./machines inputs;
  };
}
