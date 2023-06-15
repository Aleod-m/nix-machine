{
  description = "A nix developement flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    fu.url = "github:numtide/flake-utils";
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rnix-lsp = {
      url = "github:nix-community/rnix-lsp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs }: 
    fu.lib.eachDefaultSystem (system: 
    let 
      pkgs = import nixpkgs { inherit system };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          alejandra.defaultpackage.${system}
          qmk
          rnix-lsp.defaultpackage.${system}
        ];
      };
    }
  );
}
