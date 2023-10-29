{ pkgs
, lib
, ...
}: let 
  ## Enable services without any other configuration needed.
  enableServices = ss: 
    let 
      paths = map (s: lib.setAttrByPath ["services" s "enable"] true) ss;
    in lib.lists.foldl lib.attrsets.recursiveUpdate {} paths

; in 
  # Imports the hardware configuration
{ imports = [ ./hardware.nix ]

; fonts.fonts = with pkgs; [ nerdfonts ]

; console = 
  { font = "Lat2-Terminus16"
  ; keyMap = "us"
  ; }
; } // enableServices 
[ "flatpak"
]

