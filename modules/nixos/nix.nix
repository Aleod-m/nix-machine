{ pkgs
, lib
, config
, ...
}: 
let cfg = config.nix
; types = lib.types
; in 
{ options = 
  { nix = 
    { flakes.enable = lib.mkOption 
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
      ; nix.extraOptions = ''
        experimental-features = nix-command flakes
        keep-outputs = true
        keep-derivations = true
      ''
      ; })
    (lib.mkIf cfg.gc.enable 
      { nix.autoOptimiseStore = true
      ; nix.settings.auto-optimise-store = lib.mkDefault true
      ; nix.gc.automatic = lib.mkDefault true
      ; nix.gc.options = lib.mkDefault "--delete-older-than 10d"
      ; }) 
  ]
; }
