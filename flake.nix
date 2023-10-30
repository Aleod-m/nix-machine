{ description = "AdrienDML nixos config"

; inputs = 
  { nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05"
  ; home-manager = 
    { url = "github:nix-community/home-manager/release-23.05"
    ; inputs.nixpkgs.follows = "nixpkgs"
    ; }
  ; flake-utils.url = "github:numtide/flake-utils"
  ; hyprland.url = "github:hyprwm/Hyprland?tag=v0.31.0"
  ; }

; outputs = { self, nixpkgs, ...} @ inputs: 
  { devShells.x86_64-linux.default =
    let 
      devPkgs = (import nixpkgs) { system = "x86_64-linux"; };
    in devPkgs.mkShell 
    { packages = with devPkgs; 
      [ git
        rnix-lsp
        just
      ]
    ; }
  ; inherit (import ./modules) nixosModules homeManagerModules mixedModules

  ; homeConfigurations = import ./users inputs 

  ; nixosConfigurations = import ./machines inputs

  ; }
; }
