{
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  environment.systemPackages = with pkgs; [
    # Clip board.
    wl-clipboard
    # Screen and brightness.
    wlr-randr
    wl-gammactl
    brightnessctl
    wlsunset
  ];

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
