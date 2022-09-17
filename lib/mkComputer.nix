{ self, ... } @ inputs:
{ name, users, system, pkgs ? import <nixpkgs>}:  
let 
  userDefs = map (name: import "${self}/users/${name}" inputs) users;
in pkgs.lib.nixosSystem {
  inherit system pkgs;
  specialArgs = {inherit inputs self;};
  modules = [
    { networking.hostName = name; } # Configure the hostName from the provided name.
    ("${self}/hardware/${name}.nix") # Add the hardware config for this machine.
  ] ++ builtins.attrValues self.nixosModules # Add my own modules.
    ++ userDefs; # Add the users.
}
