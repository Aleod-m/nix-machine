inputs: { config, lib, ...}: with lib;
let 
  cfg = config.generalKeybinds;
in {
  
  options = {
    enable = mkOption {
      type = types.bool;
      description = "Whether to enable the general keybinds to be picked up by all the software."
    };
    
    left = mkOption {
      type = inputs.lib.types.key;
      description = "The key to mean left.";
    };
    right = mkOption {
      type = inputs.lib.types.key;
      description = "The key to mean right.";
    };
    up = mkOption {
      type = inputs.lib.types.key;
      description = "The key to mean up.";
    };
    down = mkOption {
      type = inputs.lib.types.key;
      description = "The key to mean down.";
    };
    next = mkOption {
      type = inputs.lib.types.key;
      description = "The key to mean next.";
    };
    previous = mkOption {
      type = inputs.lib.types.key;
      description = "The key to mean previous.";
    };
  };
}