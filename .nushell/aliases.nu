alias mv = ^mv
alias ll = ^exa -la

alias backup-clear = clear

def clear [] {
    if $nu.os-info.family == 'windows' {
        ^cls
    } else {
        backup-clear
    }
}

alias "scoop search" = scoop-search
