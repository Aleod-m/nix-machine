{
  description = "Aleod nixos config";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    # My personnal theme.
    konokai = {
      url = "github:Aleod-m/konokai";
      flake = false;
    };

    # Missing tree-sitter grammars I need.
    tree-sitter-nu = {
      url = "github:nushell/tree-sitter-nu";
      flake = false;
    };

    tree-sitter-just = {
      url = "github:IndianBoy42/tree-sitter-just";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
    ...
  } @ inputs:
  flake-utils.lib.eachDefaultSystem (system: let 
    pkgs = nixpkgs.legacyPackages.${system};
    nixvim' = nixvim.legacyPackages.${system};
  in {
    packages = {
      # My nix vim configuration as a derivation.
      nixvim = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        module = import ./config;
      };
    };

  }) // {
    # My nix vim modules.
    nixvimConfiguration = import ./config;
    # The nix vim modules i author.
    nixvimModules = ./modules;
  };
}
