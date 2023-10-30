{ pkgs
, lib
, config
, ...
}: 
let cfg = config.nix
; types = lib.types
; boolToString = b: if b then "true" else "false"
; in 
{ options = 
  { nix = 
    { allowedUnfree = lib.mkOption 
      { type = types.listOf types.string
      ; default = []
      ; }
    
    ; flakes.enable = lib.mkOption 
      { type = types.bool
      ; default = true
      ; description = ''
        Enable nix flakes.
      ''
      ; }
    # TODO: implement config
    ; flakes.keep-outputs = lib.mkOption 
      { type = types.bool
      ; default = true
      ; description = ''
        Enable nix flakes.
      ''
      ; }
    # TODO: implement config
    ; flakes.keep-derivations = lib.mkOption 
      { type = types.bool
      ; default = true
      ; description = ''
        Enable nix flakes.
      ''
      ; }

    ; gc.enable = lib.mkEnableOption 
      { type = types.bool
      ; default = true
      ; description = ''
        Enable nix flakes.
      ''
      ; }
    ; }
  ; }

; config = lib.mkMerge 
  [ (lib.mkIf cfg.flakes.enable 
      { nix.package = pkgs.nixFlakes
      ; nix.extraOptions = let 
        keep-outputs = boolToString cfg.flakes.keep-outputs;
        keep-derivations = boolToString cfg.flakes.keep-derivations;
      in ''
        experimental-features = nix-command flakes
        keep-outputs = ${keep-outputs}
        keep-derivations = ${keep-derivations}
      ''
      ; })
    (lib.mkIf cfg.gc.enable 
      { nix.autoOptimiseStore = true
      ; nix.settings.auto-optimise-store = lib.mkDefault true
      ; nix.gc.automatic = lib.mkDefault true
      ; nix.gc.options = lib.mkDefault "--delete-older-than 10d"
      ; }) 
    (lib.mkIf (cfg.allowedUnfree != []) 
      { nixpkgs.config.allowUnfree = true
      ; nixpkgs.config.allowUnfreePredicate = 
        pkgs: __elem (lib.getName pkgs) config.allowedUnfree
      ; }
    )
  ]
; }
