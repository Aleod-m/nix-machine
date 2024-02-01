lib:
lib.makeExtensible (self: let 
  callLibs = file: (import file) {lib = self;};
in {
  inherit callLibs;
  utils = callLibs ./utils.nix;
  inherit (self.utils) mkModOpt MkTypedOpt;
})
