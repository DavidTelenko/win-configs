const nushellDir = ($nu.config-path | path parse).parent
const configDir = ($nushellDir | path parse).parent

def grid-ls [] {
    ls
    | sort-by type name -i
    | grid -c
}
alias lsg = grid-ls

alias backup-clear = clear
def clear [] {
    backup-clear --keep-scrollback
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

    if ($toKill | is-empty) {
        print $"'($processName)' not found"
        return
    }

    print $toKill
    print "Are you sure you want to kill all of this?"

    if ((['yes', 'no'] | input list) == 'yes') {
        $toKill | each { kill -f $in.pid }
    }
}

alias sk = search-kill
alias mv = ^mv
alias lg = lazygit
alias ll = ^exa -la --icons=auto
alias old-cat = cat
alias cat = ^bat --theme=gruvbox-dark
alias vi = nvim
alias dnf = sudo dnf -y
alias scoop = powershell scoop

alias conf = nvim $configDir

alias ghce = gh copilot explain
alias ghcs = gh copilot suggest

alias "scoop search" = __scoop_search

let home = if $nu.os-info.family == "windows" {
    [$env.HOMEDRIVE, $env.HOMEPATH] | path join
} else {
    $env.HOME
}

def transcribe-last-audio-message [] {
    [$home, Downloads]
    | path join
    | ls $in
    | sort-by modified -r
    | first
    | get name
    | qstt $in
}

def translate [word: string] {
    [$home, Documents, Utility, Dictionaries, eng-rus.txt]
    | path join
    | open $in
    | rg $word
}

alias tlam = transcribe-last-audio-message

def todo [] {
    [$home, Documents, Markdowned, Todo]
    | path join
    | nvim $in
}

def mark [] {
    [$home, Documents, Markdowned]
    | path join
    | nvim $in
}

alias cal = cal --week-start mo
alias ffmpeg = ffmpeg -hide_banner

const modules = [$nushellDir, modules] | path join
const pc = [$modules, "pc.nu"] | path join
use $pc

alias pcs = pc sleep
alias pcr = pc reboot
alias pcn = pc snooze
alias v = nvim .
alias c = clear
