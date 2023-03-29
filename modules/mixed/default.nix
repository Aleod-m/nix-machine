{self, ...} @ inputs:
self.lib.modules.importAndPropagateInputs inputs ./. [
  "hyprland"
]