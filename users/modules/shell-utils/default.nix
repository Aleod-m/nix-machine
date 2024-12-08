{pkgs, config, ...}: { 
  programs.zoxide = { enable = true; };
  programs.starship = { enable = true; };
  programs.direnv = { enable = true; nix-direnv.enable = true; };
}
