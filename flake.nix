{ description = "AdrienDML nixos config"

; inputs = 
  { nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05"
  ; nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"
  ; home-manager = 
    { url = "github:nix-community/home-manager"
    ; inputs.nixpkgs.follows = "nixpkgs-unstable"
    ; }
  ; flake-utils.url = "github:numtide/flake-utils"
  ; hyprland.url = "github:hyprwm/Hyprland?tag=v0.31.0"
  ; }

; outputs = { self, nixpkgs-unstable, ...} @ inputs: 
  { devShells.x86_64-linux.default =
    let 
      devPkgs = (import nixpkgs-unstable) { system = "x86_64-linux"; };
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
