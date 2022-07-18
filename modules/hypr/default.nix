{config, pkgs,lib, self, user, ...}: with lib; {

    imports = [
        ./../desktop-base
    ];

    options = {
        hypr = {
            enable = mkEnableOption "hypr";
        };
    };

    config = mkIf config.hypr.enable {
        wayland = true;
        programs.hyprland.enable = true;
    };
}
