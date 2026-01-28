{
  pkgs,
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
    lorien
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
		dbeaver-bin
    # jetbrains.idea-community
    signal-desktop
    meld
    qutebrowser
    inotify-tools
    blueman
    logseq
    aider-chat
    iftop
    watchexec
		tldr
    proton-pass
		drone-cli
  ];

  programs = {
    atuin.enable = true;
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = let 
        tmuxCmd = __concatStringsSep " " [
					"GIT_AUTHOR_NAME=\"Adrien Derobert-Mazure\" GIT_AUTHOR_EMAIL=\"adrien.derobertmazure@biblibre.com\""
          "/usr/bin/tmux -L ADM"
          "set-option -g mode-keys vi \\;"
          "set-option -g base-index 1 \\;"
          "set-option -g renumber-windows on \\;"
          "set-option -g default-command \"bash --rcfile ~/tools/numahop/alias.sh\"\\;"
          "new-session -A \\;"
        ];
        prodTmuxCmd = __concatStringsSep " " [ tmuxCmd "set-option -g status-bg red \\;" ];
      in {
        # Apply environement.
        "*" = {
          forwardAgent = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          compression = false;
          addKeysToAgent = "no";
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
        };

        env = {
          host = "bs-numahop* *-numahop";
          setEnv = {
            TERM="xterm";
          };
          extraOptions.RequestTTY = "force";
        };
        # Proxies
        bib-proxy = {
          user = "biblibre";
          hostname = "bs-support.biblibre.com";
        };
        bib-proxy-storage = {
          user = "biblibre";
          hostname = "bs-stockage.biblibre.com";
        };
        # Instances
        support-instances = {
          host = "aderobert-* mmeusburger-* cjoyet-*";
          user = "numahop";
          proxyJump = "bib-proxy";
          extraOptions.RemoteCommand = tmuxCmd;
          addKeysToAgent = "yes";
        };
        prod-1 = {
          host = "bs-numahop*";
          user = "root";
          addKeysToAgent = "yes";
          extraOptions.RemoteCommand = prodTmuxCmd;
        };
        prod-2 = {
          match =  "Host *-numahop User numahop";
          proxyJump = "bib-proxy-storage";
          addKeysToAgent = "yes";
          extraOptions.RemoteCommand = prodTmuxCmd;
        };
      };
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
      settings.user = {
        name = "Adrien Derobert-Mazure";
        email = "adrien.derobertmazure@biblibre.com";
      };
      ignores = [".envrc" ".direnv" ".devenv"];
    };
  };

  services.nextcloud-client.enable = true; 
  services.protonmail-bridge.enable = true;
}
