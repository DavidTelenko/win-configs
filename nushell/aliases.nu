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

# Creating a symlink in a left to right manor `link_name -> existing` (auto& link_name = existing)
def symlink [
    link_name: path  # The name of the symlink
    existing: path   # The existing file
] {
    let link_name = ($link_name | path expand)
    let existing = ($existing | path expand -s)

    if $nu.os-info.family != 'windows' {
        ln -s $existing $link_name | ignore
    } 

    if ($existing | path type) == 'dir' {
        mklink /D $link_name $existing
        return
    } 

    mklink $link_name $existing
}

def auto-commit [] {
    git add .
    git commit -m $'(date now)'
    git push
}

def ddg [...search: string] {
    start $"https://duckduckgo.com/?hps=1&q=($search | str join '+')&atb=v411-1&ia=web"
}

def timer [dur: duration, message?: string = 'Timer is done' ] {
    sleep $dur;
    powershell -NoProfile -Command $"New-BurntToastNotification -AppLogo '' -Text '($message)', '($dur) passed'"
}
