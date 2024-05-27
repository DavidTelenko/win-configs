const nushellDir = ($nu.config-path | path parse).parent
const configDir = ($nushellDir | path parse).parent

def grid-ls [] {
    ls | sort-by type name -i | grid -c
}
alias lsg = grid-ls

def open-in-nvim [what: string] {
    cd $what; nvim .; cd -;
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

alias conf = open-in-nvim $configDir

alias ghce = gh copilot explain
alias ghcs = gh copilot suggest

alias "scoop search" = __scoop_search

def transcribe-last-audio-message [] {
    ls D:\Downloads\ | sort-by modified -r | first | get name | qstt $in
}

alias tlam = transcribe-last-audio-message

alias todo = open-in-nvim D:\Temp\todo
alias mark = open-in-nvim D:\Documents\Markdowned
alias cal = cal --week-start mo
alias ffmpeg = ffmpeg -hide_banner
