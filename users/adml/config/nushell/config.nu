#      ____ ____     ___  ___ _
#     / _  |  __ \  /   |/   | |  AdrienDML
#    / /_| | |  \ \/ /| | /| | |  https://github.com/AdrienDML
#   / ___  | |__/ / / |  / | | |___
#  /_/   |_|_____/_/  |_/  |_|____/
# Nushell Config File

# Get just the extern definitions without the custom completion commands
use completions.nu *
use hooks.nu
use menus.nu 
use keybinds.nu 
use colors.nu

use functions.nu *
use job.nu
# for more information on themes see
# https://www.nushell.sh/book/coloring_and_theming.html

# The default config record. This is where much of your global configuration is setup.
$env.config = {
  show_banner: false
  table: {
      mode: rounded
      index_mode: always
      trim: {
          methodology: wrapping
          wrapping_try_keep_words: true
          truncating_suffix: "..."
      }
  }
  ls: {
    use_ls_colors: true
    clickable_links: true
  }
  rm: {
    always_trash: false
  }
  history: {
      max_size: 1000
      sync_on_enter: true
      file_format: "plaintext"
  }
  completions: {
      quick: true
      partial: true
      case_sensitive: false
      algorithm: "fuzzy"
      external: {
          enable: true
          completer: null
      }
  }
  color_config: (colors default)
  filesize: {
      metric: true
      format: "auto"
  }
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2
  buffer_editor: "emacs" # command that will be used to edit the current line buffer with ctr+e
  use_ansi_coloring: true
  edit_mode: vi # emacs, vi
  shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
  hooks: (hooks)
  menus: (menus)
  keybindings: (keybinds)
}

source aliases.nu

source ~/.config/nushell/starship/init.nu
source ~/.config/nushell/zoxide/zoxide.nu
#source ~/.config/nushell/nuFetch.nu
