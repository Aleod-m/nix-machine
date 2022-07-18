{ config, lib, ... }: 
let
  cfg = config.programs.neovim;
  theme = config.theme;
  keys = config.keys;
in {
  imports = [
    ./../keys
    ./../theme
  ];

  options = {
    extraPlugins = mkOption {
        type = with types; listOf (string);
        description = "The list of plugins to use";
    };
    
    mapLeader = mkOption {
        type = types.keyType;
        description = "Key to act as leader";
    };

    mapOption = types.submodule {
          silent = mkOption {
            type = types.bool;
            description = "Whether this mapping should be silent. Equivalent to adding <silent> to a map.";
            default = false;
          };

          nowait = mkOption {
            type = types.bool;
            description = "Whether to wait for extra input on ambiguous mappings. Equivalent to adding <nowait> to a map.";
            default = false;
          };

          script = mkOption {
            type = types.bool;
            description = "Equivalent to adding <script> to a map.";
            default = false;
          };

          expr = mkOption {
            type = types.bool;
            description = "Means that the action is actually an expression. Equivalent to adding <expr> to a map.";
            default = false;
          };

          unique = mkOption {
            type = types.bool;
            description = "Whether to fail if the map is already defined. Equivalent to adding <unique> to a map.";
            default = false;
          };

          noremap = mkOption {
            type = types.bool;
            description = "Whether to use the 'noremap' variant of the command, ignoring any custom mappings on the defined action. It is highly advised to keep this on, which is the default.";
            default = true;
          };

          action = mkOption {
            type = types.str;
            description = "The action to execute.";
          };

          description = mkOption {
            type = types.nullOr types.str;
            description = "A textual description of this keybind, to be shown in which-key, if you have it.";
            default = null;
        };
      };
    };
    mapOptions = mode: mkOption {
        type = types.bool;
        description = types.bool;
    }

  };
}
