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
      ls = eza;
      ld = eza + "-d";
      la = eza + "-a -l";
      lg = eza + "-l --git --header";
      lga = eza + "-a -l --git --header";

      disks = "lsblk -o NAME,LABEL,MOUNTPOINTS,TYPE,SIZE,FSUSE%,FSAVAIL";
      disksj = "lsblk -J -O";
      # nvim
      nv = "nvim";
      # git
      ga = git + "add";
      gA = git + "add --all";
      gcm = git + "commit -m";
      gco = git + "checkout";
      gca = git + "commit --amend -m";
      gs = git + "status";
      gl = git + "log --oneline -n 10";
      gll = git + "log --oneline";
      glg = git + "log --graph --oneline";
      glgl = git + "log --graph";
      gf = git + "fetch";
      gp = git + "pull";
      gd = git + "diff";
      gdc = git + "diff --cached";
      gw = git + "worktree";
      gbl = git + "branch -vv";
    };
  };
}
