{
  description = "Aleod nixos config";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland?tag=v0.35.0";
    nixvim = {
      url = "path:./nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    nixvim,
    ...
  } @ inputs: let
    pkgs = (import nixpkgs) {system = "x86_64-linux";};
    generic = flake-utils.lib.eachDefaultSystem (system: {
      devShells = {
        default = pkgs.mkShell {
          # All the programs i need to edit my config.
          packages = with pkgs; [
            # The nix lsp i use.
            rnix-lsp
            # to run the nix flake commands.
            just
          ];
          DIRENV_LOG_FORMAT = "";
        };
        # A simple rust shell
        # `nix shell github:Aleod-m/nix-machine#simple-rust`
        simple-rust = pkgs.mkShell {
          packages = with pkgs; [
            rustc
            cargo
            rust-analyzer
          ];
        };
      };

      formatter = pkgs.alejandra;

      pkgs = {
        nixvim = nixvim.packages.${system}.nixvim;
      };
    });
  in generic // {
    inherit (import ./modules) nixosModules homeManagerModules mixedModules;

    # Extend nixpkgs library.
    lib = import ./lib nixpkgs;

    homeConfigurations = import ./users inputs;

    nixosConfigurations = import ./machines inputs;
  };
}
