{
  description = "A basic rust flake";

  inputs = {
    fu.url = "github:numtide/flake-util";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, fu }:
    fu.lib.eachDefaultSystem (system:
      let
        overlays = [
          rust-overlay.overlay (
            self: super: {
              rustc = self.rust-bin.stable.latest.default;
              cargo = self.rust-bin.stable.latest.default;
            }
          )
        ];
        pkgs = (import nixpkgs) {
            inherit system ovelays;
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs =  with pkgs; [
            # rust compilator
            rustc
            # rust build system 
            cargo
            cargo-edit
            cargo-watch
            cargo-expand
            # rust LSP 
            rust-analyzer
            # Common deps for building rust crates
            pkgsconfig
          ];
        };
      };
    }
  );
}
