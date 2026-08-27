#!/bin/bash
# ============================================================================
# Configuration
# ============================================================================

INSTALL_APT_LIST_EASY=true
INSTALL_FLATPAK_LIST_EASY=true
PURGE_APT_LIST_EASY=true
CHANGE_GNOME_SCREENSHOT_SAVE_LOCATION=true
GNOME_SCREENSHOT_SAVE_LOCATION=~/Documents/Screenshots

# ============================================================================
# Package Lists
# ============================================================================
APT_PACKAGES_EASY=(
    git
    chromium # install extension and set settings, if possible
    ttf-mscore-fonts-installer
    font-manager
    neofetch
    htop
    steam-installer
)

FLATPAK_PACKAGES_EASY=(
    com.github.tchx84.Flatseal
    com.tomjwatson.Emote
    com.spotify.Client
    com.belmoussaoui.Authenticator
    de.haeckerfelix.Shortwave
    com.rafaelmardojai.Blanket
    org.kde.kclock
    com.discordapp.Discord
    org.gnome.Aisleriot
    org.gnome.Chess
    org.localsend.localsend_app
    com.github.unrud.VideoDownloader
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
greeting_function() {
    echo "Welcome!"
}

exit_function() {
    echo "Goodbye!"
}

log() {
    echo
    echo "==> $1"
}

install_apt_easy() {
    if [[ "$INSTALL_APT_LIST_EASY" != true]]; then
        return
    fi
    log "installing easy apt packages"
    sudo apt update
    sudo apt install -y "${APT_PACKAGES_EASY[@]}"
}

install_flatpak_easy() {
    if [[ "$INSTALL_FLATPAK_LIST_EASY" != true]]; then
        return
    fi
    log "installing easy flatpak packages"
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install -y "${FLATPAK_PACKAGES_EASY}"
}
purge_apt_easy() {
    if [[ "$PURGE_APT_LIST_EASY" != true]]; then
        return
    fi
    log "purging easy apt packages"
    sudo apt purge -y "${APT_PURGE_EASY[@]}"
    sudo apt update
}

set_screenshot_save_location() {
    if [[ "${CHANGE_GNOME_SCREENSHOT_SAVE_LOCATION}" != true]]; then
        return
    fi
    log "changing save location to ${GNOME_SCREENSHOT_SAVE_LOCATION}"
}

# ============================================================================
# Main
# ============================================================================

greeting_function
sudo -v

install_apt_easy
install_flatpak_easy
purge_apt_easy
set_screenshot_save_location

exit_function
