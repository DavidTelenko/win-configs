use './dirs.nu' *
const core = [$modules, core.nu] | path join

use $core *

def read-lines [path: string] {
    [$configDir $path]
    | path join
    | if ($in | path exists) {
        $in
        | open --raw
        | lines
        | where { $in !~ '^ *#.+$' }
    }
}

$env.PROMPT_COMMAND = {||
    let dir = $env.PWD | path split | if (
        $in | zip ($nu.home-path | path split) | all { $in.0 == $in.1 }
    ) {
        $env.PWD | str replace $nu.home-path "~" | path split
    } else { $in } | if (
        ($in | length) > 2
    ) {
        $in | select 0 (($in | length) - 1) | [$in.0 '..' $in.1]
    } else { $in } | path join

    let duration = $env.CMD_DURATION_MS | into int | into duration --unit ms

    [
        $"(ansi green)@(whoami) "
        $"(ansi magenta)nu "
        $"(ansi yellow)($dir) "
        $"(ansi white)($duration)"
        $"(char newline)"
        $"(ansi light_blue)> "
    ] | str join
}

$env.PROMPT_COMMAND_RIGHT = {||
    let time_segment = [
        (ansi green)
        (date now | format date '%I:%M:%S %p')
    ]

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ])} else { "" }

    [
        $last_exit_code (char space)
        # $time_segment
    ] | flatten | str join
}

$env.PROMPT_INDICATOR = {|| "" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.PROMPT_MULTILINE_INDICATOR = {|| "" }

$env.TRANSIENT_PROMPT_COMMAND = {|| "> " }
$env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
$env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

read-lines '.env'
| if not ($in | is-empty) {
    $in
    | each { split row '=' | { $in.0: $in.1 } }
    | reduce { |it| merge $it }
    | load-env
}

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
if not (is-windows) {
    $env.PATH = ($env.PATH | split row (char esep)
        | prepend $'($env.HOME)/bin'
        | prepend $'($env.HOME)/.local/bin'
        | prepend $'($env.HOME)/.bun/bin'
        | prepend $'($env.HOME)/.cargo/bin'
        | prepend $'($env.HOME)/go/bin'
        | prepend $'($env.HOME)/.spicetify'
        | prepend (read-lines '.path')
        | uniq
    )
} else {
    $env.TERM = 'xterm-256color'
    $env.Path = ($env.Path | split row (char esep)
        | prepend (read-lines '.path')
        | uniq
    )
}

def try-init [cmd, util] {
    try {
        do $cmd
    } catch {
        $"($util) failed to run, try to install this util with cargo or package manager"
    }
}

try-init {
    $env.LS_COLORS = (vivid generate gruvbox-dark-soft | str trim)
} vivid

try-init {
    zoxide init nushell | save -f ([$localVendor, zoxide.nu] | path join)
} zoxide

const out = [$localVendor, omp.nu] | path join
rm -f $out

if not (is-wezterm) {
    const theme = [$configDir, oh-my-posh, themes, my.omp.toml] | path join
    try-init {
        oh-my-posh init nu --eval --config $theme | save -f $out
    } oh-my-posh
}
