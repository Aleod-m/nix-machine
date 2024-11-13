let 
  workKey = __readFile ./work.key.pub;
  # persoKey = __readFile ./perso.key.pub;
in {
  "bibvpn_ca.crt.age".publicKeys = [ workKey ];
  "bibvpn_cert.crt.age".publicKeys = [ workKey ];
  "bibvpn_key.key.age".publicKeys = [ workKey ];
  "bibvpn_ta.key.age".publicKeys = [ workKey ];
}
