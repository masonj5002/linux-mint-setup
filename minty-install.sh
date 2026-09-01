#!/bin/bash
# ============================================================================
# Configuration
# ============================================================================

SWITCH_TO_FASTLY_REPO=true

INSTALL_APT_LIST_EASY=true
INSTALL_FLATPAK_LIST_EASY=true
PURGE_APT_LIST_EASY=true

INSTALL_VSCODE=true
INSTALL_ZOOM_WITH_MODS=true
INSTALL_TTR=true
#INSTALL_ESR_PURGE_FIREFOX_WITH_MODS=true
# INSTALL_KOLOURPAINT_WITH_MODS=true
# INSTALL_LIBREOFFICE_PURGE_APT=true
# INSTALL_BOTTLES_DOWNLOAD_WIZARD=true

CHANGE_GNOME_SCREENSHOT_SAVE_LOCATION=true
GNOME_SCREENSHOT_SAVE_LOCATION=~/Documents/Screenshots

# ============================================================================
# Package Lists
# ============================================================================

APT_PACKAGES_EASY=(
    git
    ttf-mscorefonts-installer
    font-manager
    neofetch
    htop
    steam-installer
    # chromium # install extension and set settings, if possible
)

FLATPAK_PACKAGES_EASY=(
    com.github.tchx84.Flatseal
    com.tomjwatson.Emote
    org.kde.kclock
    com.belmoussaoui.Authenticator
    de.haeckerfelix.Shortwave
    com.rafaelmardojai.Blanket
    org.gnome.Aisleriot
    org.gnome.Chess
    org.localsend.localsend_app
    com.github.unrud.VideoDownloader
    com.spotify.Client
    com.discordapp.Discord
    # com.usebottles.bottles # also install Wizard101

)

APT_PURGE_EASY=(
    cups-browsed
)

DEB_FILES=(
    

)

# ============================================================================
# Helper Functions
# ==========================================================================

log() {
    echo
    echo "==> $1"
}

greeting_function() {
    log "Welcome!"
    sleep 1
}

exit_function() {
    log "Goodbye! Please reboot!"
    sleep 1
}

fastly_repo() {
    if [ "$SWITCH_TO_FASTLY_REPO" != true ] ; then
        return 1
    fi
    log "Switching to Fastly CDN..."
    for file in /etc/apt/sources.list.d/official-package-repositories.list ; do
        sudo sed -i 's/packages.linuxmint.com/fastly.linuxmint.io/g' "$file"
    done

    update_only_apt
}

update_only_apt() {
    log "Updating apt package list..."
    sudo apt update
}

update_upgrade_apt() {
    update_only_apt
    log "Upgrading apt packages..."
    sudo apt upgrade -y
}

purge_apt_easy() {
    if [ "$PURGE_APT_LIST_EASY" != true ] ; then
        return 1
    fi
    log "purging easy apt packages"
    sudo apt purge -y "${APT_PURGE_EASY[@]}"
    update_only_apt
}

install_apt_easy() {
    if [ "$INSTALL_APT_LIST_EASY" != true ] ; then
        return 1
    fi
    log "Installing easy apt packages..."
    sudo apt install -y "${APT_PACKAGES_EASY[@]}"
}

install_flatpak_easy() {
    if [ "$INSTALL_FLATPAK_LIST_EASY" != true ] ; then
        return 1
    fi
    log "installing easy flatpak packages"
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install -y --noninteractive "${FLATPAK_PACKAGES_EASY[@]}"
}

vscode() {
    if [ "${INSTALL_VSCODE}" != true ] ; then
        return 1
    fi
    log "installing VSCode..."

    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft.gpg

    echo "Types: deb
    URIs: https://packages.microsoft.com/repos/code
    Suites: stable
    Components: main
    Architectures: amd64
    Signed-By: /usr/share/keyrings/microsoft.gpg" |
    sed 's/^[[:space:]]*//' |
    sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null
}

zoom_with_mods() {
    if [ "${INSTALL_ZOOM_WITH_MODS}" != true ] ; then
        return 1
    fi
    log "Installing Zoom with mods..."

    wget https://zoom.us/client/latest/zoom_amd64.deb &&
    sudo apt install -y ./zoom_amd64.deb &&
    rm zoom_amd64.deb

    timeout -s INT 8s zoom

    for file in ~/.config/zoomus.conf ; do
    echo "hello!"
        sed -i 's/enableMiniWindow=true/enableMiniWindow=false/g' "$file"
    done
}

ttr() {
    if [ "${INSTALL_TTR}" != true ] ; then
        return 1
    fi
    log "Installing TTR"

    TTR_URL=https://cdn.toontownrewritten.com/launcher/linux/launcher.flatpakref
    sudo flatpak install --system -y ${TTR_URL}
}

set_screenshot_save_location() {
    if [ "${CHANGE_GNOME_SCREENSHOT_SAVE_LOCATION}" != true ] ; then
        return 1
    fi
    log "changing screenshot save location to ${GNOME_SCREENSHOT_SAVE_LOCATION}"

    mkdir ~/Documents/Screenshots
}

# ============================================================================
# Main
# ============================================================================

greeting_function
sudo -v

fastly_repo
update_upgrade_apt

purge_apt_easy
install_apt_easy
install_flatpak_easy

vscode
zoom_with_mods
ttr

set_screenshot_save_location

update_upgrade_apt
exit_function
