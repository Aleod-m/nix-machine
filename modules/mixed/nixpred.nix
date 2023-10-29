{ lib
, config
, ...
}: 
let inherit (lib) types
; cfg = config.nix
; in 
{ options =
  { nix.allowedUnfree = lib.mkOption 
    { type = types.listOf types.string
    ; default = []
    ; };
  }
; config = lib.mkIf (cfg.allowedUnfree != []) 
  { nixpkgs.config.allowUnfree = true
  ; nixpkgs.config.allowUnfreePredicate = 
      pkgs: __elem (lib.getName pkgs) config.allowedUnfree
  ; }
; }
