const nushellDir = ($nu.config-path | path parse).parent
const configDir = ($nushellDir | path parse).parent

def grid-ls [] {
    ls | sort-by type name -i | grid -c
}

def edit-config [] {
    cd $configDir # cd into config directory so that nvim will use it as cwd
    nvim '.'      # nvim into this dir
    cd -          # cd back to avoid side effects
}

alias backup-clear = clear
def clear [] {
    if $nu.os-info.family == 'windows' {
        ^cls
    } else {
        backup-clear
    }
}

# weird shenanigan but aliasing 'scoop search' directly to 'scoop-search' makes
# it search the word 'search')
def __scoop_search [param: string] {
    scoop-search $param
}

def auto-commit [] {
    git add .
    git commit -m $'(date now)'
    git push
}

alias mv = ^mv
alias lg = lazygit
alias ll = ^exa -la --icons=auto
alias old-cat = cat
alias cat = ^bat --theme=gruvbox-dark
alias vi = nvim

alias conf = edit-config

alias ghce = gh copilot explain
alias ghcs = gh copilot suggest

alias "scoop search" = __scoop_search
