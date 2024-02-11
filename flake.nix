{
  description = "AdrienDML nixos config";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland?tag=v0.35.0";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs: let
    devPkgs = (import nixpkgs) {system = "x86_64-linux";};
    generic = flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = devPkgs.mkShell {
        # All the programs i need to edit my config.
        packages = with devPkgs; [
          # The nix lsp i use.
          rnix-lsp
          # The lua lsp for my neovim config
          lua-language-server
          # to run the nix flake commands.
          just
        ];
        DIRENV_LOG_FORMAT = "";
      };

      formatter = devPkgs.alejandra;
    });
  in generic // {
    inherit (import ./modules) nixosModules homeManagerModules mixedModules;

    # Extend nixpkgs library.
    lib = import ./lib nixpkgs;

    homeConfigurations = import ./users inputs;

    nixosConfigurations = import ./machines inputs;
  };
}
