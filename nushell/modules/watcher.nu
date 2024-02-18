export def main [path: string, out: string = "pdf"] {
    let parsed = $path | path parse
    let ext = $parsed.extension

    if ($ext == "md") {
        watch $path { ||
            pandoc -s --css=stylesheet.css $"($path | path expand)" -o $"D:/Temp/Out/($parsed.stem)/($parsed.stem).($out)" -t $out 
        }
    }
}
