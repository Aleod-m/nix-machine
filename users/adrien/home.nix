{
  pkgs,
  zen-browser,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  home.shells = {
    default = "bash";
    enabled = ["bash" "nushell"];
  };

  home.sessionVariables = {
    NVIM_DEV_PLUGIN_PATH = "/home/adrien/Documents/perso/nvim-plugins";
  };

  home.packages = with pkgs; [
    spotify
    pavucontrol
    bat
    pciutils
    zoxide
    zip
    unzip
    wget
    socat
    libreoffice
    onlyoffice-bin
    bitwarden-cli
    bitwarden-desktop
    openvpn
    thunderbird
    seafile-client
    rocketchat-desktop
    vscode
    chromium
    jetbrains.idea-community
    signal-desktop
    meld
    qutebrowser
    inotify-tools
    blueman
    aider-chat
  ] ++ [zen-browser.packages.${pkgs.system}.default];

  programs = {
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      extraConfig = let 
        tmuxCmd = __concatStringsSep " " [
          "/usr/bin/tmux -L ADM"
          "set-option -g mode-keys vi \\;"
          "set-option -g base-index 1 \\;"
          "set-option -g renumber-windows on \\;"
          "new-session -A \\;"
        ];
        prodTmuxCmd = __concatStringsSep " " [ tmuxCmd "set-option -g status-bg red \\;" ];
      in ''
        Host bib-proxy
          HostName bs-support.biblibre.com
          User biblibre

        Host bs-numahop* aderobert-* mmeusburger-*
          SetEnv TERM=xterm
          RequestTTY force

        Host aderobert-* mmeusburger-*
          ProxyJump bib-proxy
          RemoteCommand ${tmuxCmd}

        Host bs-numahop*
          RemoteCommand ${prodTmuxCmd}
      '';
    };

    tmate = {
      host = "tmate.biblibre.com";
      port = 2223;
      rsaFingerprint = "SHA256:HSH4PfoThYNtkrRZ7Zyw9HXkITkhT/ZksmFf2nZX/Ag";
      dsaFingerprint = "SHA256:62b9/JSA1j1yisZkbFvK2Uk/BG/uQQpws6FDY6iFCfc";
    };
    htop.enable = true;
    git = {
      enable = true;
      userName = "Adrien Derobert-Mazure";
      userEmail = "adrien.derobertmazure@biblibre.com";
      ignores = [".envrc" ".direnv" ".devenv"];
    };
  };
  services.nextcloud-client.enable = true; 
}
