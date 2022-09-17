{ self, ... } @ inputs:
{ name, users, system, pkgs ? import <nixpkgs>}: 
let 
  userDefs = map (name: import "${self}/users/${name}" inputs) users;
  config = import "${self}/machines/configs/${name}";
  hardware= import "${self}/machines/hardware/${name}";
in pkgs.lib.nixosSystem {
  inherit system pkgs;
  specialArgs = {inherit inputs self;};
  modules = [
    {
      system.stateVersion = "21.11";
      networking.hostName = name;
    } # Configure the hostName from the provided name.
    hardware # Add the hardware config for this machine.
    config # Add the configuration for this machine.
  ] ++ builtins.attrValues self.nixosModules # Add my own modules.
    ++ userDefs; # Add the users.
}
