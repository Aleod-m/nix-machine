inputs: {
  # Automates the nixos configuration creation
  mkComputer = import ./mkComputer.nix inputs;

  # Automates the user home environnement creation
  mkUser = import ./mkUser.nix inputs;

  # Keyboard helper functions.
  Keyboard = import ./keyboard inputs;

  # Create an attribute set that inport all the modules in the mods argument and pass the inputs in the ins argument to it.
  modules.importAndPropagateInputs = ins: basePath: mods: 
    builtins.listToAttrs (
      map (moduleName: {
        name = moduleName;
        value = import (basePath + "/${moduleName}") ins;
      })
      mods
    );
}
