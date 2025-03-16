$env.PROMPT_COMMAND = {||
    $env.LAST_PROMPT_TIME = date now

    let dir = $env.PWD | path split | if (
        $in | zip ($nu.home-path | path split) | all { $in.0 == $in.1 }
    ) {
        $env.PWD | str replace $nu.home-path "~" | path split
    } else { $in } | if (
        ($in | length) > 2
    ) {
        $in | select 0 (($in | length) - 1) | [$in.0 '..' $in.1]
    } else { $in } | path join

    [
        $"(ansi green)@(whoami) "
        $"(ansi magenta)nu "
        $"(ansi yellow)($dir)"
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

    ([$last_exit_code (char space) $time_segment] | flatten | str join)
}

# The prompt indicators are environmental variables that represent
# the state of the prompt
# $env.PROMPT_INDICATOR = {|| "> " }
# $env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
# $env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
# $env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

$env.PROMPT_INDICATOR = {|| "" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.PROMPT_MULTILINE_INDICATOR = {|| "" }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
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

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
if $nu.os-info.family != "windows" {
    $env.PATH = ($env.PATH | split row (char esep)
        | prepend $'($env.HOME)/bin'
        | prepend $'($env.HOME)/.local/bin'
        | prepend $'($env.HOME)/.bun/bin'
        | prepend $'($env.HOME)/.cargo/bin'
        | prepend $'($env.HOME)/go/bin'
        | prepend $'($env.HOME)/.spicetify'
        | uniq
    )
} else {
    $env.TERM = 'xterm-256color'
}

const nushellDir = ($nu.config-path | path parse).parent
const configDir = ($nushellDir | path parse).parent

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
    zoxide init nushell | save -f ~/.zoxide.nu
} zoxide

try-init {
    oh-my-posh init nu --config ([$configDir, oh-my-posh, themes, my.omp.toml] | path join)
} oh-my-posh

try-init {
    broot --print-shell-function nushell | save -f ~/.broot.nu
} broot
