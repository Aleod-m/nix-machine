nixpkgs: let 
  blib = nixpkgs.lib.extend (_: _: builtins);
in blib.extend (_: _: (import ./lib.nix blib))
