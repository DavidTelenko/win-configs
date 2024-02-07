export def main [dur: duration, message?: string = 'Timer is done' ] {
    sleep $dur;
    powershell -NoProfile -Command $"New-BurntToastNotification -AppLogo '' -Text '($message)', '($dur) passed'"
}
