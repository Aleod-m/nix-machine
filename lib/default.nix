{ self
, ...
} 
@ inputs: 
  let use = (module: (import module) inputs)
  ; c = self.lib.combinator
  ; in 
  { inherit use
  ; useall = 
      basepath: 
      c.apply_all modules [ (mod: (basepath ++ mod)) use ] 
  ; combinator = import ./combinators.nix
  ; } 
