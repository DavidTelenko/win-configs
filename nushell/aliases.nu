const nushellDir = ($nu.config-path | path parse).parent
const configDir = ($nushellDir | path parse).parent

def grid-ls [] {
    ls | sort-by type name -i | grid -c
}
alias lsg = grid-ls

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

def transcribe-last-audio-message [] {
    ls D:\Downloads\ | sort-by modified -r | first | get name | qstt $in
}

def translate [word: string] {
    let home = if $nu.os-info.family == "windows" {
        $env.HOMEPATH
    } else {
        $env.HOME
    }

    open (
        $'($home)\Documents\Utility\Dictionaries\eng-rus.txt'
    ) | rg $word
}

alias tlam = transcribe-last-audio-message

alias todo = nvim D:\Documents\Markdowned\Todo
alias mark = nvim D:\Documents\Markdowned
alias cal = cal --week-start mo
alias ffmpeg = ffmpeg -hide_banner

const modules = ([$nushellDir, modules] | path join)
const pc = [$modules, "pc.nu"] | path join
use $pc

alias pcs = pc sleep
alias pcr = pc reboot
