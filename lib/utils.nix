lib: let
  l = lib;
  t = lib.types;
in {
  mkModOpt = submodule: l.mkOption {
    type = t.submodule submodule;
  };
  mkTypedOpt = type: l.mkOption { type = t; };
}
