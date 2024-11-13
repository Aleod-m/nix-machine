{
  pkgs,
  lib,
  config,
  ...
}: {
  age.secrets = {
    "bibvpn_ca.crt".file = ./secrets/bibvpn_ca.crt.age;
    "bibvpn_crt.crt".file = ./secrets/bibvpn_crt.crt.age;
    "bibvpn_key.key".file = ./secrets/bibvpn_key.key.age;
    "bibvpn_ta.key".file = ./secrets/bibvpn_ta.key.age;
  };

  services.openvpn.servers = {
    bibvpn = {
      autoStart = false;
      config = ''
        client
        remote bs-acces.biblibre.com
        remote-crt-tls server
        ca ${config.age.secrets."bibvpn_ca.crt".path}
        crt ${config.age.secrets."bibvpn_crt.crt".path}
        key ${config.age.secrets."bibvpn_key.key".path}
        comp-lzo yes
        dev tun
        proto udp
        tls-auth ${config.age.secrets."bibvpn_ta.key".path} 1
        nobind
        auth-nocache
        script-security 2
        persist-key
        persist-tun
        user nobody
        group nogroup
        data-ciphers AES-256-CBC
      '';
    };
  };
}
