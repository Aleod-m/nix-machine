{
  pkgs,
  config,
  ...
}: {
  programs.bash = {
    enable = __elem "bash" config.home.shells.enabled;
    bashrcExtra = __readFile ./extra.sh;
    shellAliases = let
      eza = "${pkgs.eza}/bin/eza ";
      git = "${pkgs.git}/bin/git ";
    in {
      # ls replacement
      ls = eza + "-x";
      ld = eza + "-d";
      la = eza + "-a -l";
      lg = eza + "-l --git --header";
      lga = eza + "-a -l --git --header";

      nr = "nix registry";
      nf = "nix flake";
      ns = "nix shell";

      disks = "lsblk -o NAME,LABEL,MOUNTPOINTS,TYPE,SIZE,FSUSED,FSUSE%";
      disksj = "lsblk -J -O";
      # nvim
      nv = "nvim";
      zel = "zellij";
      # git
      ga = git + "add";
      gau = git + "add -u";
      gA = git + "add --all";
      gcm = git + "commit -m";
      gco = git + "checkout";
      gs = git + "status";
      gl = git + "log -n 10 --oneline";
      gL = git + "log";
      glg = git + "log --graph";
      gfh = git + "log -p --";
      gf = git + "fetch";
      gp = git + "pull";
      gd = git + "diff";
      gdc = git + "diff --cached";
      gw = git + "worktree";
      gb = git + "branch";
      gbl = git + "branch -vv";
    };
  };
}
