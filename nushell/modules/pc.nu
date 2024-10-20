# For now implemented only to work for windows, however all necessary
# mechanisms were put into this module to work seamlessly on any platform and
# to be semi-easily configurable

use core.nu *

# Runs arbitury powershell command assuming it's installed on the system and
# mounted into Path env variable
def powershell_run [command] {
    powershell -NoProfile -Command $command
}

def load_win_impl [moduleName: string] {
    [$nushellDir, modules, impl, windows, $moduleName]
    | path join
    | open -r $in
    | return $in
}

# Implementation detail, acts like a switch between platform functions, it's
# not recommended to use this function outside the module
def impl [f, ...rest] {
let platform = (
    $nu.os-info.family
    | if $in == 'windows' {{
        hibernate: {
            rundll32.exe powrprof.dll,SetSuspendState Hibernate
        }
        sleep: {
            rundll32.exe powrprof.dll,SetSuspendState Sleep
        }
        restart: {
            shutdown.exe -r -t 00
        }
        bios: {
            shutdown.exe -r -fw -t 00
        }
        shutdown: {
            shutdown.exe -s -t 00
        }
        snooze: {
            "snooze.ps1" | load_win_impl $in | powershell_run $in | ignore
        }
        volume_set: { |val, pid|
            let win_volume = "volume.ps1" | load_win_impl $in

            if ($pid != null) {
                powershell_run $"($win_volume) [audio]::Volume = ($val)"
                return
            }

            powershell_run $"($win_volume) [audio]::Volume = ($val)"
        }
        volume_mute: {
            let win_volume = "volume.ps1" | load_win_impl $in
            powershell_run $"($win_volume) [audio]::Mute = $true"
        }
        volume_unmute: {
            let win_volume = "volume.ps1" | load_win_impl $in
            powershell_run $"($win_volume) [audio]::Mute = $false"
        }
    }} else if $in == 'unix' {{
        hibernate: {
            systemctl hibernate
        }
        sleep: {
            systemctl suspend
        }
        restart: {
            systemctl reboot
        }
        bios: {
            systemctl reboot --firmware-setup
        }
        shutdown: {
            systemctl poweroff
        }
        volume_set: { |val, pid|
        }
        volume_mute: {
            amixer set Master toggle
        }
    }} else {{
    }}
)

do ($platform | get $f) ...$rest
}

# Puts computer to hibernation state if possible
export def hibernate [] { impl hibernate }

# Puts computer to sleep state if possible
export def sleep [] { impl sleep }

# Restarts computer
export def restart [] { impl restart }

# restart alias computer
export def reboot [] { impl restart }

# Turns off computer
export def shutdown [] { impl shutdown }

# Turns off monitor(s)
export def snooze [] { impl snooze }

# Sets volume to desired value
export def "volume set" [
    value: float,
    --pid: int,
] {
    impl volume_set $value $pid
}

export def "volume mute" [] { impl volume_mute }

export def "volume unmute" [] { impl volume_unmute }

# Alias for sys
export def main [] {
    sys
}
