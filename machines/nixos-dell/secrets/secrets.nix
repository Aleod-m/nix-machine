let
  workKey = __readFile ./work.key.pub;
  nixos-dellKey = __readFile ./work.key.pub;
  # persoKey = __readFile ./perso.key.pub;
in {
  "bibvpn_ca.crt.age".publicKeys = [workKey nixos-dellKey];
  "bibvpn_crt.crt.age".publicKeys = [workKey nixos-dellKey];
  "bibvpn_key.key.age".publicKeys = [workKey nixos-dellKey];
  "bibvpn_ta.key.age".publicKeys = [workKey nixos-dellKey];
}
