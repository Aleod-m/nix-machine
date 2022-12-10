_: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.de.awesome;
in {
  options = {
    de.awesome.enable = mkEnableOption "awesome";
  };

  config = mkIf cfg.enable {
    de.displayProtocol = "x11";
    services = {
      xserver.windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
        ];
      };
      picom = {
        enable = true;
      };
    };
  };
}
