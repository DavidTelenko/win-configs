export def main [] {
  git add .
  git commit -m $'(date now)'
  git push
}
