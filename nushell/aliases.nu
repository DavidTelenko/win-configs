alias mv = ^mv
alias ll = ^exa -la --icons=auto

def grid-ls [] {
    ls | sort-by type name -i | grid -c
}

alias lg = grid-ls

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

alias "scoop search" = __scoop_search
