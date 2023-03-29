{self, ...} @ inputs:
self.lib.modules.importAndPropagateInputs inputs ./. [
  # "keyboard.nix"
]
