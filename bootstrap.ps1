# Simple scoop based bootstrap script for a fresh system

param (
    [Switch] $Egg = $false
)

$Chicken = !$Egg

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iex "& { $(irm get.scoop.sh) } -RunAsAdmin"

if ($Chicken) {
    scoop install git
    git clone https://github.com/DavidTelenko/win-configs.git ~/.configs
}

scoop import ~/.configs/scoop/scoopfile.json
# & ~/.configs/init.ps1

# separate spicetify+spotx install
iex "& { $(iwr -useb 'https://raw.githubusercontent.com/SpotX-Official/spotx-official.github.io/main/run.ps1') } -confirm_uninstall_ms_spoti -confirm_spoti_recomended_over -podcasts_off -block_update_on -start_spoti -new_theme -adsections_off -lyrics_stat spotify"
iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.ps1 | iex
iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.ps1 | iex
