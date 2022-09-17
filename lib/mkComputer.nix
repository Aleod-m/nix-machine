{ self, pkgs ? <nixpkgs>, ... } @ inputs:
{ name, users, system }:  
let 
  userDefs = map (name: import "${self}/users/${name}" inputs) users;
in pkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {inherit inputs self;};
  modules = [
    { networking.hostName = name; }
    ("${self}/hardware/${name}.nix")
  ] ++ __attrValues self.nixosModules
    ++ userDefs;
}

