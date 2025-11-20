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
    # bibvpn = {
    #   autoStart = false;
    #   config = ''
    #     client
    #     remote bs-acces.biblibre.com
    #     remote-cert-tls server
    #     comp-lzo yes
    #     dev tun
    #     proto udp
    #     nobind
    #     auth-nocache
    #     script-security 2
    #     persist-key
    #     persist-tun
    #     user nobody
    #     group nogroup
    #     data-ciphers AES-256-CBC
    #     ca ${config.age.secrets."bibvpn_ca.crt".path}
    #     cert ${config.age.secrets."bibvpn_crt.crt".path}
    #     key ${config.age.secrets."bibvpn_key.key".path}
    #     tls-auth ${config.age.secrets."bibvpn_ta.key".path} 1
    #   '';
    # };
    biblibre = {
      autoStart = false;
      config = ''
        client
        remote bs-vpn.biblibre.com
        dev tun
        proto udp
        nobind
        auth-nocache
        script-security 2
        persist-key
        persist-tun
        ca ${config.age.secrets."bibvpn_ca.crt".path}
        cert ${config.age.secrets."bibvpn_crt.crt".path}
        key ${config.age.secrets."bibvpn_key.key".path}
        tls-auth ${config.age.secrets."bibvpn_ta.key".path} 1
      '';
    };
  };
}
