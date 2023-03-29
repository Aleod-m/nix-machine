inputs:
{ pkgs, lib, ... }: 
with lib; 
let
  l = lib;
  t = l.types;
in {
  
  color = t.enum [
    rgbColor
    rgbaColor
    hslColor
    hsvColor
  ];
    
  rgbaColor = types.submodule {
    r = mkOption { type = t.ints.u8; };
    g = mkOption { type = t.ints.u8; };
    b = mkOption { type = t.ints.u8; };
    a = mkOption { type = t.nullOr t.ints.u8; default = null; };
  };

  hslColor = types.submodule {
    h = mkOption { type = types.ints.between 0 360; };
    s = mkOption { type = types.ints.between 0 100; };
    l = mkOption { type = types.ints.between 0 100; };
    a = mkOption { type = t.nullOr t.ints.u8; default = null; };
   };

  hsvColor = types.submodule {
    h = mkOption { type = types.ints.between 0 360; };
    s = mkOption { type = types.ints.between 0 100; };
    v = mkOption { type = types.ints.between 0 100; };
    a = mkOption { type = t.nullOr t.ints.u8; default = null; };
  };
  
  isRgb = color: (color ? r) && (color ? g) && (color ? b);
  
  isRgba = color: (isRgb color) && color ? a;

  colorToHex = color: "";
}
