def powershell_run [command] {
  powershell -NoProfile -Command $command
}

export def impl [f, ...rest] {
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
            shutdown: {
              shutdown.exe -s -t 00
            }
            snooze: {
              powershell_run '(Add-Type -MemberDefinition "[DllImport(""user32.dll"")]`npublic static extern int PostMessage(int hWnd, int hMsg, int wParam, int lParam);" -Name "Win32SendMessage" -Namespace Win32Functions -PassThru)::PostMessage(0xffff, 0x0112, 0xF170, 2)' | ignore
            }
        }} else if $in == 'linux' {{
        }} else {{
        }}
    )

    do ($platform | get $f) ...$rest
}

# Puts computer to hibernation state if possible
export def hibernate [] {
    try { impl hibernate } catch { echo "Not yet implemented" }
}

# Puts computer to sleep state if possible
export def sleep [] {
    try { impl sleep } catch { echo "Not yet implemented" }
}

# Restarts computer
export def restart [] {
    try { impl restart } catch { echo "Not yet implemented" }
}

# Turns off computer
export def shutdown [] {
    try { impl shutdown } catch { echo "Not yet implemented" }
}

# Turns off monitor(s)
export def snooze [] {
    try { impl snooze } catch { echo "Not yet implemented" }
}

export def main [] {
  sys
}
