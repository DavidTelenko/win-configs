# cspell: disable
const nushellDir = ($nu.config-path | path parse).parent
const configDir = ($nushellDir | path parse).parent
const modules = [$nushellDir, modules] | path join

const core = [$modules, core.nu] | path join
const pc = [$modules, pc.nu] | path join

use $core *
use $pc

let platform_dirs = ($nu.os-info.family | if $in == "windows" {{
    data: $env.LOCALAPPDATA
    home: ([$env.HOMEDRIVE, $env.HOMEPATH] | path join)
    temp: $env.TEMP
}} else {{
    data: $env.XDG_DATA_HOME
    home: $env.HOME
    temp: $env.TMPDIR
}})

let dirs = $platform_dirs
    | insert videos {
        try { $env.VIDEOSDIR } catch { "D:/Videos" }
    }

def grid-ls [] {
    ls | sort-by type name -i | grid -c
}

# alias backup-clear = clear
# def clear [] {
#     backup-clear --keep-scrollback
# }

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

def search-kill [processName: string] {
    let toKill = ps | where name =~ ("(?i)" + $processName)

    $toKill | is-empty | if $in {
        print $"'($processName)' not found"
        return 1
    }

    print $toKill

    print "Are you sure you want to kill all of this?"

    ['yes', 'no'] | input list | if $in == 'yes' {
        $toKill | each {
            try {
                kill -f $in.pid
            }
        }
        return 0
    }

    return 1
}

def translate [word: string] {
    [$dirs.home, Documents, Utility, Dictionaries, eng-rus.txt]
    | path join
    | open $in
    | rg $word
}

def open_nvim [what: list<string>] {
    $what | path join | do {
        cd $in
        nvim $in
    }
}

def search-url [...query: string] {
    try {
        start $"($env.PREFERRED_SEARCH_ENGINE)?q=($query | str join ' ')"
    } catch {
        start $"https://duckduckgo.com/?q=($query | str join ' ')"
    }
}

def record-screen [] {
    let captures_dir = [$dirs.videos, "Captures"] | path join

    mkdir $captures_dir # create if not exist

    let filepath = [
        $captures_dir,
        $"Capture_(date now | format date '%Y-%m-%d_%H-%M-%S').mp4"
    ] | path join

    # TODO: figure out the best usability parametrization of these two

    const rate_control = 20
    const preset = "p7"

    (ffmpeg
        -framerate 60
        -offset_x 1920          # this selects offset to second monitor
        -video_size 1920x1080   # resolution {width}x{height}
        -f gdigrab              # video grabber
        -i desktop              # input device
        -c:v h264_nvenc         # codec (nvidia nvenc)
        -preset:v $preset       # preset (p1-p7 lower is ++speed --quality/size)
        -profile:v high         # limits the output to a specific H.264 profile
        -tune:v hq              # tune preset
        -pix_fmt yuv420p        # pixel format (for dumb players)
        -rc:v vbr               # constant quality vbr mode
        -cq:v $rate_control     # rate control (0-51 lower is ++quality --size)
        -bf:v 2                 # b-frames
        -b:v 0                  # bitrate (reset)
        $filepath
    )
}

def wiztree-pic [
    destination?: path,
    --width: number = 1920,
    --height: number = 1080,
] {
    let dest_png = [$dirs.temp, "wiztree_tmp.png"] | path join
    try { rm $dest_png }

    (wiztree $"($destination | default pwd)"
        /treemapimagefile=$"($dest_png)"
        /treemapimagewidth=$"($width)"
        /treemapimageheight=$"($height)")

    retry -r 5 {
        sleep 5sec
        start $dest_png
    }

    return $dest_png
}

def clean-dir [dir: path, --older: duration = 1wk] {
    let toDelete = $dir | ls $in | where modified < ((date now) - $older)

    $toDelete | is-empty | if $in {
        print $"(ansi green)'($dir)' (ansi reset)does not have files older then ($older)"
        return
    }

    print $toDelete
    print "Are you sure you want to delete all of this?"

    ['yes', 'no'] | input list | if $in == 'yes' {
        $toDelete | each { rm -rf $in.name }
    }
}

def clean-shada [--older: duration = 1wk] {
    clean-dir ([$dirs.data, nvim-data, shada] | path join) --older $older
}

def clean-pwd [--older: duration = 1wk] { clean-dir $"(pwd)" --older $older }
def clean-tmp [--older: duration = 1day] { clean-dir $dirs.temp --older $older }

def restart [processName: string] {
    search-kill $processName | if $in == 0 {
        ^$"($processName)"
    }
}

alias todo = open_nvim [$dirs.home, Documents, Markdowned, Todo]
alias mark = open_nvim [$dirs.home, Documents, Markdowned]

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
# alias mv = ^mv
# disk picture
alias dp = wiztree-pic
# record screen
alias rs = record-screen
alias lg = lazygit
alias ll = ^exa -la --icons=auto
alias vi = nvim
alias dnf = sudo dnf -y

alias scoop = powershell scoop
alias "scoop search" = __scoop_search
alias "scoop i" = powershell scoop install
alias "scoop u" = powershell scoop uninstall
alias "scoop ls" = powershell scoop list

alias conf = nvim $configDir
alias jmplst = nvim $env.JUMP_LIST
