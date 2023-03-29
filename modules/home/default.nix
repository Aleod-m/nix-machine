{self, ...} @ inputs:
self.lib.modules.importAndPropagateInputs inputs ./. [
  "nixDefaults"
  # "keyboard" # TODO Finish kmonad config
  #"hyprland" # TODO Make config generation in nix
  #"nvim" # TODO Make config generation in nix
  #"extractUtils"
  #"rustUtils"
  #"starship"
  #"theme"
  #"globalkeys"
]
