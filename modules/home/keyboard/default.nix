inputs: {
  config,
  lib,
  pkgs,
  system,
  ...
}: let
  # short hands
  l = lib;
  t = lib.types;
  cfg = config.de.keyboard;

  /* Keyboard type submodule.
   * 
   * Type:
   *   {str, ...} -> {
   *     name: str,
   *     device: path,
   *     extaGroups: [str],
   *     composeKey: str,       //TODO: Create a key type.
   *     fallthrough: bool,
   *     allowCommands: bool,
   *     config: str | path,    //TODO: Create a layout type. Using kmonad file format for now.
   *   }
   */
  keyboard = {name, ...}: {
    options = {
      name = l.mkOption {
        type = t.str;
        example = "laptop-internal";
        default = name;
        description = "Keyboard name.";
      };
      device = l.mkOption {
        type = t.path;
        example = "/dev/input/by-id/some-dev";
        description = "The keyboard device by path or id";
      };
      extraGroups = lib.mkOption {
        type = t.listOf t.str;
        default = [];
        example = ["openrazer"];
        description = ''
          Extra permission groups to attach to the KMonad instance for
          this keyboard.

          Since KMonad runs as an unprivileged user, it may sometimes
          need extra permissions in order to read the keyboard device
          file.  If your keyboard's device file isn't in the input
          group you'll need to list its group in this option.
        '';
      };
      composeKey = l.mkOption {
        type = t.nullOr t.str;
        default = "ralt";
        description = "The optional compose key to use";
      };
      fallthrough = l.mkEnableOption "Reemit unhandled key events";
      allowCommands = l.mkEnableOption "Allow keys to run commands.";
      config = l.mkOption {
        type = t.either t.str t.path;
      };
    };
  };


  /*Function for generating the config file.
  * 
  * Type:
  *   keyboard -> file
  */
  mkConfigFile = (keyboard:
    let 
    defcfg = ''
      (defcfg
        input (device-file "${keyboard.device}")
        input (uinput-sink "cutom-${keyboard.name}")
    '' + (l.optionalString (keyboard.composeKey != null) ''
      cmp-seq ${keyboard.composeKey}
    '') + ''
        fallthrough ${lib.boolToString keyboard.fallthrough}
        allow-cmd ${lib.boolToString keyboard.allowCommands}
      )
    '';
    config = if builtins.isString keyboard.config then keyboard.config else l.fileContents keyboard.config;
    in pkgs.writeTextFile {
      name = "kmonad-${keyboard.name}.cfg";
      text = defcfg + "\n" + config;
      checkPhase = "${cfg.custom.package}/bin/kmonad -d $out";
    }
  );

  /* Function for generating the systemd service.
  */
  mkService = keyboard:
  let
    cmd = [
      "${cfg.custom.package}/bin/kmonad"
      "--input"
      ''device-file "${keyboard.device}"''
    ] ++ [
      "${mkConfigFile keyboard}"
    ];

    groups = [
      "input"
      "uinput"
    ] ++ keyboard.extraGroups;
  in {
    name = "kmonad-${keyboard.name}";
    value = {
      description = "KMonad for ${keyboard.device}";
      script = lib.escapeShellArgs cmd;
      serviceConfig.Restart = "no";
      serviceConfig.User = "kmonad";
      serviceConfig.SupplementaryGroups = groups;
      serviceConfig.Nice = -20;
    };
  };

  /* Function for generating the systemd path.
  */
  mkPath = keyboard: rec {
    name = "kmonad-${keyboard.name}";
    value = {
      description = "KMonad trigger for ${keyboard.device}";
      wantedBy = [ "default.target" ];
      pathConfig.Unit = "${name}.service";
      pathConfig.PathExists = keyboard.device;
    };
  };

in {

  imports = [
    { nixpkgs.overlays = [inputs.kmonad.overlays.default]; }
  ];

  options.de.keyboard = {
    enable = l.mkEnableOption "keyboard configuration";
    custom = {
      enable = l.mkEnableOption "custom keyboard";
      keyboards = l.mkOption {
        type = t.attrsOf (lib.types.submodule keyboard);
        default = { };
        description = "Keyboard configuration.";
      };
      kmonad-package = l.mkOption {
        type = t.package;
        default = pkgs.kmonad;
        description = "The KMonad package to use.";
        example = "pkgs.haskellPackages.kmonad";
      };
    };
  };

  config = l.mkIf cfg.enable {
    services.xserver = {
      layout = cfg.layout;
      xkbVariant = cfg.variant;
      xkbOptions = cfg.options;
    };
  } // l.mkIf cfg.custom.enable {
    environment.systemPackages = [ cfg.custom.kmonad-package ];
    users.extraGroups = {
      uinput = {};
      kmonad = {};
    };
    services.udev.extraRules = ''
      KERNEL=="uinput", MODE"0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    systemd.paths =
      builtins.listToAttrs
        (map mkPath (builtins.attrValues cfg.custom.keyboards));

    systemd.services =
      builtins.listToAttrs
        (map mkService (builtins.attrValues cfg.custom.keyboards));
  };
}