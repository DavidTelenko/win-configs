export def main [dur: duration] {
    sleep $dur;
    powershell -NoProfile -Command $"New-BurntToastNotification -AppLogo '' -Text 'Timer is done', '($dur) passed'"
}
