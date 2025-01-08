{
  pkgs,
  config,
  mlib,
  ...
}:
mlib.enable.programs ["btop" "zoxide" "starship"] {
  home.packages = with pkgs; [
    bat
    zellij
    ripgrep
    eza
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
