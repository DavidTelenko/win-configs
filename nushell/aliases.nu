const nushellDir = ($nu.config-path | path parse).parent
const configDir = ($nushellDir | path parse).parent
const modules = [$nushellDir, modules] | path join
const pc = [$modules, "pc.nu"] | path join
use $pc

let home = if $nu.os-info.family == "windows" {
    [$env.HOMEDRIVE, $env.HOMEPATH] | path join
} else {
    $env.HOME
}

def grid-ls [] {
    ls
    | sort-by type name -i
    | grid -c
}

alias backup-clear = clear
def clear [] {
    backup-clear --keep-scrollback
}
def wipe [] {
    backup-clear
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

def search-kill [processName] {
    let toKill = ps | where name =~ ("(?i)" + $processName)

    $toKill | is-empty | if $in {
        print $"'($processName)' not found"
        return
    }

    print $toKill

    print "Are you sure you want to kill all of this?"

    ['yes', 'no'] | input list | if $in == 'yes' {
        $toKill | each { kill -f $in.pid }
    }
}

def translate [word: string] {
    [$home, Documents, Utility, Dictionaries, eng-rus.txt]
    | path join
    | open $in
    | rg $word
}

def open_nvim [what: list<string>] {
    $what
    | path join
    | do {
        cd $in
        nvim $in
    }
}

def search-url [...query: string] {
    try {
        start $"($env.PREFERED_SEARCH_ENGINE)?q=($query | str join ' ')"
    } catch {
        start $"https://duckduckgo.com/?q=($query | str join ' ')"
    }
}

alias todo = open_nvim [$home, Documents, Markdowned, Todo]
alias mark = open_nvim [$home, Documents, Markdowned]

alias cal = cal --week-start mo
alias ffmpeg = ffmpeg -hide_banner

alias pcs = pc sleep
alias pcr = pc reboot
alias pcn = pc snooze

alias enva = pc env add
alias envr = pc env remove

alias patha = pc path add
alias pathr = pc path remove
alias pathls = pc path list

alias v = nvim .
alias c = clear

alias lsg = grid-ls
alias sk = search-kill
alias mv = ^mv
alias lg = lazygit
alias ll = ^exa -la --icons=auto
alias vi = nvim
alias dnf = sudo dnf -y
alias scoop = powershell scoop

alias conf = nvim $configDir
alias jmplst = nvim $env.JUMP_LIST

alias "scoop search" = __scoop_search
