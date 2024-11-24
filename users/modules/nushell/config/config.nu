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
  footer_mode: 25 # always, never, number_of_rows, auto
  float_precision: 2
  buffer_editor: "emacs" # command that will be used to edit the current line buffer with ctr+e
  use_ansi_coloring: true
  edit_mode: vi # emacs, vi
  shell_integration: {
      # osc2 abbreviates the path if in the home_dir, sets the tab/window title, shows the running command in the tab/window title
      osc2: true
      # osc7 is a way to communicate the path to the terminal, this is helpful for spawning new tabs in the same directory
      osc7: true
      # osc8 is also implemented as the deprecated setting ls.show_clickable_links, it shows clickable links in ls output if your terminal supports it
      osc8: true
      # osc9_9 is from ConEmu and is starting to get wider support. It's similar to osc7 in that it communicates the path to the terminal
      osc9_9: false
      # osc133 is several escapes invented by Final Term which include the supported ones below.
      # 133;A - Mark prompt start
      # 133;B - Mark prompt end
      # 133;C - Mark pre-execution
      # 133;D;exit - Mark execution finished with exit code
      # This is used to enable terminals to know where the prompt is, the command is, where the command finishes, and where the output of the command is
      osc133: true
      # osc633 is closely related to osc133 but only exists in visual studio code (vscode) and supports their shell integration features
      # 633;A - Mark prompt start
      # 633;B - Mark prompt end
      # 633;C - Mark pre-execution
      # 633;D;exit - Mark execution finished with exit code
      # 633;E - NOT IMPLEMENTED - Explicitly set the command line with an optional nonce
      # 633;P;Cwd=<path> - Mark the current working directory and communicate it to the terminal
      # and also helps with the run recent menu in vscode
      osc633: true
      # reset_application_mode is escape \x1b[?1l and was added to help ssh work better
      reset_application_mode: true
  }
  hooks: (hooks)
  menus: (menus)
  keybindings: (keybinds)
}

source aliases.nu

source ($nu.cache-dir | path join gen mod.nu)
