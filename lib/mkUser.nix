{ home-manager, self, ... } @ inputs : 
username: system: pkgs:
let
  args = inputs;
  homeConfig = import "${self}/users/${username}/home.nix" inputs;
  homeDirectory = "/home/${username}"; 
in home-manager.lib.homeManagerConfiguration { 
  pkgs = pkgs.legacyPackages.${system};
  modules = [
    homeConfig
    { config.home = { inherit username homeDirectory; stateVersion = "22.11";}; }
  ] ++ builtins.attrValues self.homeModules;
}
