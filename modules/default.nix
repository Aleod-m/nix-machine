let mkMods = base: mnames: 
    let mods = map (mod: { ${mod} = import ./${base}/${mod}.nix; } ) mnames
    ; in  __zipAttrsWith (_: v: __head v) mods 
; in 
{ nixosModules = mkMods "nixos" [ "nix" ]
; homeManagerModules = mkMods "hm" [ ]
; mixedModules = mkMods "mixed" [ "nixpred" ]
; }
