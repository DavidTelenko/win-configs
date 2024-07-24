use core.nu *

const defaultVoice = (
    ["en_US", "hfc_female", "en_US-hfc_female-medium.onnx"] | path join
)

def getVoicePath [
    voice: string
] {
    return ([
        (which piper | get path.0 | path parse | get parent),
        "voices", $voice
    ] | path join)
}

export def main [
    text: string,
    voice: string = $defaultVoice
] {
    echo $text
        | piper --model (getVoicePath $voice) --output-raw
        | sox -t raw -b 16 -e signed-integer -r 22050 -c 1 - -t waveaudio pad 0 0.010
}

export def save [
    text: string,
    outPath: string,
    voice: string = $defaultVoice
] {
    echo $text | piper --model (getVoicePath $voice) --output-file $outPath
}
