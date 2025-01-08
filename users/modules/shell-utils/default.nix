{pkgs, config, ...}: 
  enablePrograms = ss: let
    paths = map (s: lib.setAttrByPath ["programs" s "enable"] true) ss;
{ 
  home.packages = with pkgs; [
    bat
    zellij
    ripgrep
    eza
    btop
  ];
  programs.btop.enable = true;
  programs.zoxide.enable = true;
  programs.starship = { enable = true; };
  programs.direnv = { enable = true; nix-direnv.enable = true; };
}
