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
    # cyberduck
    # onlyoffice-bin
    bitwarden-cli
    bitwarden-desktop
    openvpn
    thunderbird
    seafile-client
    rocketchat-desktop
    vscode
    chromium
    # jetbrains.idea-community
    signal-desktop
    meld
    qutebrowser
    inotify-tools
    blueman
    logseq
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
          "set-option -g default-command \"bash --rcfile ~/tools/numahop/alias.sh\"\\;"
          "new-session -A \\;"
        ];
        prodTmuxCmd = __concatStringsSep " " [ tmuxCmd "set-option -g status-bg red \\;" ];
      in ''
        # Proxys
        Host bib-proxy
          HostName bs-support.biblibre.com
          User biblibre

        Host bib-proxy-stockage
          HostName bs-stockage.biblibre.com
          User biblibre

        # Set global env and config.
        Host bs-numahop* *-numahop
          SetEnv TERM=xterm
          RequestTTY force

        # Support Instances
        Host aderobert-* mmeusburger-* cjoyet-* User numahop
          ProxyJump bib-proxy
          RemoteCommand ${tmuxCmd}

        # Production Instances
        Host bs-numahop* User root
          ProxyJump bib-proxy
          RemoteCommand ${prodTmuxCmd}

        Match Host *-numahop User numahop
          ProxyJump bib-proxy-stockage
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
