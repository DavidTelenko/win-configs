export def main [...search: string] {
    start $"https://duckduckgo.com/?hps=1&q=($search | str join '+')&atb=v411-1&ia=web"
}
