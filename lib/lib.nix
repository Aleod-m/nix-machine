lib:
let 
  callLibs = file: (import file) lib;
lib.makeExtensible (self: {
  utils = callLibs ./utils.nix;
  colors = callLibs ./colors.nix;

  inherit (utils) mkModOpt MkTypedOpt;
})
