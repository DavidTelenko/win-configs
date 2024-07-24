export def symlink [
    link_name: path # The name of the symlink
    existing: path  # The existing file
] {
    let link_name = ($link_name | path expand)
    let existing = ($existing | path expand -s)

    if $nu.os-info.family != 'windows' {
        ln -s $existing $link_name | ignore
    }

    if ($existing | path type) == 'dir' {
        mklink /D $link_name $existing
        return
    }

    mklink $link_name $existing
}

const nushellDir = ($nu.config-path | path parse).parent
