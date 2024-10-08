# Nushell Environment Config File

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str join (char esep) }
  }
}

# add ssh-agent
ssh-agent -c 
    | lines 
    | first 2 
    | parse "setenv {name} {value};" 
    | transpose -r 
    | into record 
    | load-env;

# Directories to search for scripts when calling source or use
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# setup gen for shell integrations dir.
if not ($nu.cache-dir| path join gen | path exists) {
    mkdir ($nu.cache-dir | path join gen)
}

if not ($nu.cache-dir| path join gen mod.nu | path exists) {
    touch ($nu.cache-dir | path join gen mod.nu)
}

# Starship
if not ($nu.cache-dir | path join gen starship.nu | path exists) {
    starship init nu 
        | save ($nu.cache-dir | path join gen starship.nu)

    open ($nu.cache-dir | path join gen mod.nu) 
        | lines 
        | append "source zoxide.nu"
        | save -f ($nu.cache-dir | path join gen mod.nu)
}

# Zoxide
if not ($nu.cache-dir | path join gen zoxide.nu | path exists) {
    zoxide init nushell --hook prompt 
        | save ($nu.cache-dir | path join gen zoxide.nu)
    open ($nu.cache-dir | path join gen mod.nu) 
        | lines 
        | append "source starship.nu"
        | save -f ($nu.cache-dir | path join gen mod.nu)
}
