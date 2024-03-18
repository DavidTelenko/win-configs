const nushellDir = ($nu.config-path | path parse).parent
const configDir = ($nushellDir | path parse).parent

alias mv = ^mv
alias ll = ^exa -la --icons=auto
alias vi = nvim
alias old-cat = cat
alias cat = ^bat --theme=base16

def edit-config [] {
    cd $configDir # cd into config directory so that nvim will use it as cwd
    nvim '.'      # nvim into this dir
    cd -          # cd back to avoid side effects
}

alias conf = edit-config

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
