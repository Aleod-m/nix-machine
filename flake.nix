{
  description = "AdrienDML nixos config";

  inputs = {
    nixpkgs-2211.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:Misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    prism.url = "github:PrismLauncher/PrismLauncher";
    flake-utils.url = "github:numtide/flake-utils";
    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {self, ...} @ inputs: let
    system = "x86_64-linux";
    devPkgs = (import inputs.nixpkgs-unstable) {inherit system;};
  in {
    lib = import ./lib inputs;

    # Modules authored.
    nixosModules = import ./modules/system inputs;
    homeModules = import ./modules/home inputs;

    devShells.${system}.default = devPkgs.mkShell {
      packages = with devPkgs; [
        alejandra
        git
        rnix-lsp
      ];
    };

    homeConfigurations = let
      overlays = with inputs; [
        prism.overlay
        neovim-nightly-overlay.overlay
      ];
    in {
      adml = self.lib.mkUser {
        inherit system overlays;
        username = "adml";
        pkgs = inputs.nixpkgs-unstable;
      };
    };

    nixosConfigurations = {
      nixos-pc = self.lib.mkComputer {
        inherit system;
        pkgs = inputs.nixpkgs-2211;
        name = "nixos-pc";
        users = ["adml"];
      };
    };
  };
}
