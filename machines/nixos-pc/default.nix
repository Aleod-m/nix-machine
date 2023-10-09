# NixOs pc hardware config
_: {
  self,
  config,
  lib,
  pkgs,
  ...
}:
let 
  enableSerivices = ss: 
  let 
    paths = map (s: ["services" s "enable"]) ss;
  in __foldl' (attr: p: lib.attrsets.setAttrByPath p attr true) {} paths;
in { 
  # Imports the hardware configuration
  imports = [ ./hardware.nix ]; 

  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

} // enableServices [
    "flatpak"
    "tailscale"
    "playerctld"
]
