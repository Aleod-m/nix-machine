{
  pkgs,
  config,
  mlib,
  ...
}: let
  bg = "191919";
  green  = "97e023";
  orange = "fa8419";
  yellow = "dfd561";
  purple = "9c64fe";
  red    = "f3005f";
  cyan   = "57d1ea";
  blue   = "0e6172";
  grey   = "929276";
  white  = "f6f6ee";
in
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
  programs.fzf = {
    enable = true;
    colors = {
      inherit bg;
      "bg+"="#293739";
      border=white;
      spinner="#E6DB74";
      hl="#7E8E91";
      fg="#F8F8F2";
      header="#7E8E91";
      info="#A6E22E";
      pointer="#A6E22E";
      marker="#F92672";
      "fg+"="#F8F8F2";
      prompt=white;
      "hl+"="#F92672";
    };
  };
}
