#!/bin/bash
# ============================================================================
# Configuration
# ============================================================================

SWITCH_TO_FASTLY_REPO=true
SETUP_TIMESHIFT_SNAPSHOTS=true

INSTALL_APT_LIST_EASY=true
INSTALL_FLATPAK_LIST_EASY=true
PURGE_APT_LIST_EASY=true

INSTALL_EXTRA_FONTS=true
INSTALL_TTF_FONTS=true
INSTALL_VSCODE=true
INSTALL_ZOOM_WITH_MODS=true
INSTALL_TTR=true
INSTALL_KOLOURPAINT_WITH_MODS=true
INSTALL_FIREFOX_ESR_PURGE_STABLE_WITH_MODS=true
INSTALL_LIBREOFFICE_FLATPAK_PURGE_APT=true
INSTALL_CHROMIUM_WITH_MODS=true
INSTALL_VIRTUALBOX_WITH_EXT_PACK=true
# INSTALL_BOTTLES_DOWNLOAD_WIZARD=true

CONFIGURE_LOGIN_WINDOW=true
CHANGE_GNOME_SCREENSHOT_SAVE_LOCATION=true
SET_CINNAMON_GTK_THEME=true
SET_WALLPAPER_SLIDESHOW=true
ADD_WORKSPACE_SWITCHER_APPLET=true
SET_DATE_FORMAT=true
INSTALL_CINNAMENU_APPLET=true
CREATE_DESKTOP_FILES=true
ADD_KEYBOARD_SHORTCUTS=true
ADD_DIRECTORIES_COLORS_BOOKMARKS=true
ADD_TEMPLATES=true
ADD_NEMO_TWEAKS=true
ADD_XED_TWEAKS=true
SET_ACCOUNT_PICTURE=true

# ============================================================================
# Config
# ============================================================================

GNOME_SCREENSHOT_SAVE_LOCATION=~/Documents/Screenshots
THEME_COLOR="Teal"
WALLPAPER_DIRECTORY_LOCATION=~/Pictures
PANEL_CLOCK_FORMAT="%l:%M %p%n%-m/%-d/%Y"  # TODO: use variables in `en_us_w10_date_format``
PANEL_CLOCK_FORMAT_TOOLTIP="%A, %B %e, %Y"
FAVORITE_APPS_LIST=\
"['chromium-browser.desktop', 'mintinstall.desktop', \
'virtualbox.desktop', 'com.rafaelmardojai.Blanket.desktop:flatpak', \
'de.haeckerfelix.Shortwave.desktop:flatpak', 'org.x.editor.desktop', \
'org.gnome.Calculator.desktop', 'org.gnome.Calendar.desktop', \
'cinnamon-settings.desktop']"

# ============================================================================
# Package Lists
# ============================================================================

APT_PACKAGES_EASY=(
    # font-manager
    neofetch
    htop
    tuptime # tracks system uptime
    # steam-installer

    ## dev tools
    git
    clang
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
)

APT_PURGE_EASY=(
    cups-browsed
)

EXTRA_FONTS_LIST=(
    fonts-comic-neue
)

DEB_FILES=(
    

)

# ============================================================================
# Misc. Variables
# ============================================================================

SUPPORTED_VERSION="zena" # 22.3 (Ubuntu 24.04 noble)

WORKSPACE_SWITCHER_PANEL="['panel1:left:0:menu@cinnamon.org:0', \
'panel1:left:1:separator@cinnamon.org:1', \
'panel1:left:2:grouped-window-list@cinnamon.org:2', \
'panel1:right:1:systray@cinnamon.org:3', \
'panel1:right:2:xapp-status@cinnamon.org:4', \
'panel1:right:3:notifications@cinnamon.org:5', \
'panel1:right:4:printers@cinnamon.org:6', \
'panel1:right:5:removable-drives@cinnamon.org:7', \
'panel1:right:6:keyboard@cinnamon.org:8', \
'panel1:right:7:favorites@cinnamon.org:9', \
'panel1:right:8:network@cinnamon.org:10', \
'panel1:right:9:sound@cinnamon.org:11', \
'panel1:right:10:power@cinnamon.org:12', \
'panel1:right:11:calendar@cinnamon.org:13', \
'panel1:right:12:cornerbar@cinnamon.org:14', \
'panel1:right:0:workspace-switcher@cinnamon.org:15']"

# ============================================================================
# Helper Functions
# ==========================================================================

log() {
    echo
    echo "==> $1"
    sleep 0.5
}

greeting_function() {
    log "Welcome!"
    sleep 1
}

version_check() {
    . /etc/os-release
    if [ $VERSION_CODENAME != $SUPPORTED_VERSION ] ; then
        echo "Unsupported OS Version. This script supports Linux Mint $SUPPORTED_VERSION. The script will now terminate."
        echo "The script will now terminate..."
        sleep 3
        return 1
    fi

    echo "You are running $NAME $VERSION. This version is supported!"
}

exit_function() {
    log "restarting Cinnamon..."
    cinnamon --replace 2>&1 >/dev/null & disown
    sleep 8
    echo -ne "\n\n"
    log "Goodbye! Please reboot!"
}

fastly_repo() {
    if [ "$SWITCH_TO_FASTLY_REPO" != true ] ; then
        return 0
    fi
    log "Switching to Fastly CDN..."
    for file in /etc/apt/sources.list.d/official-package-repositories.list ; do
        sudo sed -i 's/packages.linuxmint.com/fastly.linuxmint.io/g' "$file"
    done

    update_only_apt
}

timeshift_snapshot() {
    if [ "${SETUP_TIMESHIFT_SNAPSHOTS}" != true ] ; then
        return 0
    fi
    log "Creating a timeshift snapshot..."

    sudo timeshift --create # also initialize `timeshift.json`
    sudo timeshift --check
}

timeshift_initialization() {
    if [ "${SETUP_TIMESHIFT_SNAPSHOTS}" != true ] ; then
        return 0
    fi
    log "setting up Timeshift backups..."

    log "==> installing jq to edit json"
    sudo apt install -y jq

    timeshift_snapshot

    # keep 'daily' snapshots
    sudo jq '
    ."schedule_daily" = "true"
    ' /etc/timeshift/timeshift.json > /tmp/temp_timeshift.json
    sudo mv /tmp/temp_timeshift.json /etc/timeshift/timeshift.json

    # reads `timeshift.json`, initializing changes
    sudo timeshift --check
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
        return 0
    fi
    log "purging easy apt packages"
    sudo apt purge -y "${APT_PURGE_EASY[@]}"
    update_only_apt
}

install_apt_easy() {
    if [ "$INSTALL_APT_LIST_EASY" != true ] ; then
        return 0
    fi
    log "Installing easy apt packages..."
    sudo apt install -y "${APT_PACKAGES_EASY[@]}"
}

install_flatpak_easy() {
    if [ "$INSTALL_FLATPAK_LIST_EASY" != true ] ; then
        return 0
    fi
    log "installing easy flatpak packages"
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub --noninteractive -y "${FLATPAK_PACKAGES_EASY[@]}"
}

extra_fonts() {
    if [ "${INSTALL_EXTRA_FONTS}" != true ] ; then
        return 0
    fi
    log "installing extra fonts..."
    sudo apt install -y "${EXTRA_FONTS_LIST[@]}"
}

ttf_fonts() {
    if [ "${INSTALL_TTF_FONTS}" != true ] ; then
        return 0
    fi
    log "installing Microsoft fonts..."

    echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | sudo debconf-set-selections
    sudo apt install -y ttf-mscorefonts-installer
}

vscode() {
    if [ "${INSTALL_VSCODE}" != true ] ; then
        return 0
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

    update_only_apt
    sudo apt install -y code
}

zoom_with_mods() {
    if [ "${INSTALL_ZOOM_WITH_MODS}" != true ] ; then
        return 0
    fi
    log "Installing Zoom with mods..."

    wget https://zoom.us/client/latest/zoom_amd64.deb &&
    sudo apt install -y ./zoom_amd64.deb &&
    rm zoom_amd64.deb

    timeout -s INT 8s zoom &
    sleep 10

    for file in ~/.config/zoomus.conf ; do
        sed -i 's/enableMiniWindow=true/enableMiniWindow=false/g' "$file"
    done
}

ttr() {
    if [ "${INSTALL_TTR}" != true ] ; then
        return 0
    fi
    log "Installing TTR..."

    TTR_URL=https://cdn.toontownrewritten.com/launcher/linux/launcher.flatpakref
    sudo flatpak install --noninteractive --system -y ${TTR_URL}
}

kolourpaint_with_mods() {
    if [ "${INSTALL_KOLOURPAINT_WITH_MODS}" != true ] ; then
        return 0
    fi
    log "Installing KolourPaint..."

    flatpak install flathub  --noninteractive -y org.kde.kolourpaint
    sudo flatpak override --system --env=GTK_THEME=Adwaita:light org.kde.kolourpaint
}

firefox_esr_purge_stable_with_mods() {
    if [ "${INSTALL_FIREFOX_ESR_PURGE_STABLE_WITH_MODS}" != true ] ; then
        return 0
    fi
    log "Purging Firefox Stable and installing Firefox ESR with mods..."
    
    sudo apt purge -y firefox* mintchat # (`mintchat` depends on `firefox`)
    sudo add-apt-repository -y ppa:mozillateam/ppa
    
    echo "Package: firefox*
          Pin: release o=LP-PPA-mozillateam
          Pin-Priority: 1001

          Package: thunderbird*
          Pin: release o=LP-PPA-mozillateam
          Pin-Priority: -1" |
    sed 's/^[[:space:]]*//' |
    sudo tee /etc/apt/preferences.d/mozillateam-ppa.pref > /dev/null

    update_only_apt
    sudo apt install -y firefox-esr

    # update grouped-window-list applet
    for file in ~/.config/cinnamon/spices/grouped-window-list@cinnamon.org/2.json ; do
        sed -i 's/firefox.desktop/firefox-esr.desktop/g' "$file"
    done

    # set policy and import configurations
    sudo mkdir -p /etc/firefox/policies
    sudo cp assets/firefox-policies/policies.json /etc/firefox/policies/policies.json
    sudo chmod -R 644 /etc/firefox/policies/policies.json

    timeout -s INT 8s firefox-esr --headless &
    sleep 10
    # NOTE: after firefox-esr 142, profile is stored in `~/.local/mozilla/firefox-esr/`...
    PROFILE_PATH=$(find ~/.mozilla/firefox-esr/ -type d -name "*.default-esr*")
    cp assets/firefox-policies/user.js $PROFILE_PATH/user.js

    # Allow multitouch gestures and precision scrolling
    MOZ_USE_XINPUT2=1 | sudo tee /etc/profile.d/use-xinput2.sh

    # remove Matrix .desktop file if removed as dependency
    if ! dpkg -s mintchat &>/dev/null ; then  
        PGK_DESKTOP_PATH=~/.local/share/applications/webapp-OnlineChat4519.desktop
        if [ -e $PGK_DESKTOP_PATH ] ; then
            rm $PGK_DESKTOP_PATH
        fi
    fi
}

libreoffice_flatpak_purge_apt() {
    if [ "${INSTALL_LIBREOFFICE_FLATPAK_PURGE_APT}" != true ] ; then
        return 0
    fi
    log "Purging LibreOffice system package and installing Flatpak..."

    sudo apt purge -y libreoffice*
    flatpak install flathub --noninteractive -y org.libreoffice.LibreOffice \
                                                org.libreoffice.LibreOffice.Help
}

chromium_with_mods() {
    if [ "${INSTALL_CHROMIUM_WITH_MODS}" != true ] ; then
        return 0
    fi
    log "Installing Chromium with mods..."

    sudo apt install chromium
    xdg-mime default chromium-browser.desktop application/pdf

    sudo cp -r chromium-policies/chromium /etc/
    sudo chmod -R 644 /etc/chromium/
    sudo chmod -R a+X /etc/chromium/

}

virtualbox_with_ext_pack() {
    if [ "${INSTALL_VIRTUALBOX_WITH_EXT_PACK}" != true ] ; then
        return 0
    fi
    log "Installing Virtualbox..."

    wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc |
    sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor

    echo "Types: deb
    URIs: https://download.virtualbox.org/virtualbox/debian
    Suites: noble
    Components: contrib
    Architectures: amd64
    Signed-By: /usr/share/keyrings/oracle-virtualbox-2016.gpg" |
    sed 's/^[[:space:]]*//' |
    sudo tee /etc/apt/sources.list.d/virtualbox.sources > /dev/null

    update_only_apt
    sudo apt install -y virtualbox-7.2

    sudo usermod -a -G vboxusers $(whoami)

    wget https://download.virtualbox.org/virtualbox/7.2.16/Oracle_VirtualBox_Extension_Pack-7.2.16.vbox-extpack
    echo "y" | sudo vboxmanage extpack install Oracle_VirtualBox_Extension_Pack-7.2.16.vbox-extpack
    rm Oracle_VirtualBox_Extension_Pack-7.2.16.vbox-extpack
}

login_window() {
    if [ "${CONFIGURE_LOGIN_WINDOW}" != true ] ; then
        return 0
    fi
    log "Configuring login window..."

    sudo apt install -y numlockx

    echo "[Greeter]
          clock-format=%l:%M %p
          background=/usr/share/backgrounds/linuxmint-wallpapers/rapciu_hope.jpg
          activate-numlock=true" |
    sed 's/^[[:space:]]*//' |
    sudo tee /etc/lightdm/slick-greeter.conf > /dev/null
}

screenshot_save_location() {
    if [ "${CHANGE_GNOME_SCREENSHOT_SAVE_LOCATION}" != true ] ; then
        return 0
    fi
    log "changing screenshot save location to ${GNOME_SCREENSHOT_SAVE_LOCATION}"

    if [ ! -d ~/Documents/Screenshots ]; then
        mkdir ~/Documents/Screenshots
    fi
    
    gsettings set org.gnome.gnome-screenshot auto-save-directory \
    "file://$HOME/Documents/Screenshots"
}

cinnamon_gtk_theme() {
    if [ "${SET_CINNAMON_GTK_THEME}" != true ] ; then
        return 0
    fi
    log "setting GTK, icon, Cinnamon theme, desktop fonts, window behavior..."

    gsettings set org.cinnamon.desktop.interface gtk-theme Mint-Y-Dark-Teal
    gsettings set org.cinnamon.desktop.interface icon-theme Mint-Y-Teal
    gsettings set org.cinnamon.theme name Mint-Y-Dark-Teal

    gsettings set org.cinnamon.desktop.interface gtk-overlay-scrollbars false

    gsettings set org.nemo.desktop font "Ubuntu Bold 12"

    # new windows open center
    gsettings set org.cinnamon.muffin placement-mode 'center'


    # *reference* gsettings keys for changing Cinnamon fonts:
    ## gsettings get org.cinnamon.desktop.interface font-name
    ## gsettings get org.nemo.desktop font
    ## gsettings get org.gnome.desktop.interface document-font-name
    ## gsettings get org.gnome.desktop.interface monospace-font-name
    ## gsettings get org.cinnamon.desktop.wm.preferences titlebar-font
    ## gsettings get org.cinnamon.desktop.interface text-scaling-factor
}

wallpaper_slideshow() {
    if [ "${SET_WALLPAPER_SLIDESHOW}" != true ] ; then
        return 0
    fi
    log "setting the wallpaper directory..."

    cp -r assets/Wallpapers $WALLPAPER_DIRECTORY_LOCATION
    gsettings set org.cinnamon.desktop.background.slideshow image-source directory://$WALLPAPER_DIRECTORY_LOCATION/Wallpapers
    gsettings set org.cinnamon.desktop.background.slideshow slideshow-enabled true

}

workspace_switcher_applet() {
    if [ "${ADD_WORKSPACE_SWITCHER_APPLET}" != true ] ; then
        return 0
    fi
    log "Adding Workspace Switcher Applet..."

    gsettings get org.cinnamon enabled-applets > enabled-applets-backup-1.ini
    gsettings set org.cinnamon enabled-applets "$WORKSPACE_SWITCHER_PANEL"

    log "==> installing jq to edit json"
    sudo apt install -y jq

    WORKSPACE_SWITCHER_SETTINGS_DIRECTORY=~/.config/cinnamon/spices/workspace-switcher@cinnamon.org

    jq '
    ."display-type".value = "buttons"
    ' $WORKSPACE_SWITCHER_SETTINGS_DIRECTORY/15.json > temp.json
    mv temp.json $WORKSPACE_SWITCHER_SETTINGS_DIRECTORY/15.json

    # Set to 2 workspaces
    gsettings set org.cinnamon.desktop.wm.preferences num-workspaces "2"    
}

date_format() {
    if [ "${SET_DATE_FORMAT}" != true ] ; then
        return 0
    fi
    log "Setting date format to EN_US, Windows 10 style..."

    # user date format
    gsettings set org.cinnamon.desktop.interface clock-use-24h false

    # panel date format
    log "==> installing jq to edit json"
    sudo apt install -y jq

    CALENDAR_APPLET_DIRECTORY=~/.config/cinnamon/spices/calendar@cinnamon.org

    # TODO: FIX: USE SYSTEM VARIABLES AT TOP
    jq '
    ."use-custom-format".value = true |
    ."custom-format".value = "%l:%M %p%n%-m/%-d/%Y" |
    ."custom-tooltip-format".value = "%A, %B %e, %Y"
    ' $CALENDAR_APPLET_DIRECTORY/13.json > temp.json
    mv temp.json $CALENDAR_APPLET_DIRECTORY/13.json
}

cinnamenu_applet() {
    if [ "${INSTALL_CINNAMENU_APPLET}" != true ] ; then
        return 0
    fi
    log "installing and configuring Cinnamenu..."

    wget https://cinnamon-spices.linuxmint.com/files/applets/Cinnamenu@json.zip
    unzip Cinnamenu@json.zip -d ~/.local/share/cinnamon/applets
    rm Cinnamenu@json.zip

    # backup current `org.cinnamon enabled-applets` value
    gsettings get org.cinnamon enabled-applets > enabled-applets-backup-2.ini
    cp enabled-applets-backup-2.ini enabled-applets-cinnamenu.ini

    for file in enabled-applets-cinnamenu.ini ; do
        sed -i 's/menu@cinnamon.org/Cinnamenu@json/g' "$file"
    done

    gsettings set org.cinnamon enabled-applets "$(cat enabled-applets-cinnamenu.ini)"

    # import preferences
    log "==> installing jq to edit json"
    sudo apt install -y jq

    CINNAMENU_SETTINGS_DIRECTORY=~/.config/cinnamon/spices/Cinnamenu@json

    ## custom icon
    jq '
    ."menu-icon-custom".value = true |
    ."menu-icon".value = "start-here-symbolic" |
    ."menu-icon-size-custom".value = true |
    ."menu-icon-size".value = 32 |
    ."menu-label".value = ""
    ' $CINNAMENU_SETTINGS_DIRECTORY/0.json > temp.json
    mv temp.json $CINNAMENU_SETTINGS_DIRECTORY/0.json

    ## enable menu animations
    jq '
    ."enable-animation".value = true 
    ' $CINNAMENU_SETTINGS_DIRECTORY/0.json > temp.json
    mv temp.json $CINNAMENU_SETTINGS_DIRECTORY/0.json

    ## disable category-click
    jq '
    ."category-click".value = false 
    ' $CINNAMENU_SETTINGS_DIRECTORY/0.json > temp.json
    mv temp.json $CINNAMENU_SETTINGS_DIRECTORY/0.json
    
    ## web search option (DDG: Google = 1, ... DDG = 6 )
    jq '
    ."web-search-option".value = 6 
    ' $CINNAMENU_SETTINGS_DIRECTORY/0.json > temp.json
    mv temp.json $CINNAMENU_SETTINGS_DIRECTORY/0.json

    ## Disable "Show recent items", "Show home folder", "Show Emoji Category"
    ## Open to 'Places' (3)
    jq '
    ."show-recents-category".value = false |
    ."show-home-folder-category".value = false |
    ."show-emoji-category".value = false |
    ."open-on-category".value = 3
    ' $CINNAMENU_SETTINGS_DIRECTORY/0.json > temp.json
    mv temp.json $CINNAMENU_SETTINGS_DIRECTORY/0.json

    # Set favorites list
    gsettings set org.cinnamon favorite-apps "$FAVORITE_APPS_LIST"
}

desktop_files() {
    if [ "${CREATE_DESKTOP_FILES}" != true ] ; then
        return 0
    fi
    log "Creating '.desktop' files..."

    cp -r assets/dot-desktop-files/. ~/.local/share/applications
}

keyboard_shortcuts() {
    if [ "${ADD_KEYBOARD_SHORTCUTS}" != true ] ; then
        return 0
    fi
    log "setting keyboard shortcuts..."
    
    CUSTOM_KEYBINDING_SETTING="org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings"

    # "Windows"
    gsettings set org.cinnamon.desktop.keybindings.wm toggle-fullscreen "['<Alt>f']"
    gsettings set org.cinnamon.desktop.keybindings.wm minimize "['<Alt>a']"
    gsettings set org.cinnamon.desktop.keybindings.wm toggle-above "['<Alt>q']" # "always-on-top"

    # 'Special Key to Move and Resize Windows'
    gsettings set org.cinnamon.desktop.wm.preferences mouse-button-modifier '<Super>'

    # Custom Keyboard Shortcuts
    gsettings set org.cinnamon.desktop.keybindings custom-list \
        "['custom0', \
          'custom1', \
          'custom2', \
          'custom3', \
          'custom4', \
          'custom5', \
          'custom6', \
          'custom7', \
          'custom8']"

    gsettings set $CUSTOM_KEYBINDING_SETTING/custom0/ name "Firefox ESR"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom0/ command "firefox-esr"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom0/ binding "['<Control><Alt>f']"

    gsettings set $CUSTOM_KEYBINDING_SETTING/custom1/ name "Nemo"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom1/ command "nemo"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom1/ binding "['<Control><Alt>n']"

    gsettings set $CUSTOM_KEYBINDING_SETTING/custom2/ name "Gnome System Monitor"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom2/ command "gnome-system-monitor"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom2/ binding "['<Control><Shift>Escape']"

    gsettings set $CUSTOM_KEYBINDING_SETTING/custom3/ name "Chromium"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom3/ command "chromium"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom3/ binding "['<Control><Alt>c']"

    gsettings set $CUSTOM_KEYBINDING_SETTING/custom4/ name "Visual Studio Code"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom4/ command "code"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom4/ binding "['<Control><Alt>v']"

    gsettings set $CUSTOM_KEYBINDING_SETTING/custom5/ name "Spotify"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom5/ command "flatpak run com.spotify.Client"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom5/ binding "['<Control><Alt>s']"

    gsettings set $CUSTOM_KEYBINDING_SETTING/custom6/ name "Discord"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom6/ command "flatpak run com.discordapp.Discord"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom6/ binding "['<Control><Alt>d']"

    gsettings set $CUSTOM_KEYBINDING_SETTING/custom7/ name "LibreOffice Writer"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom7/ command "flatpak run org.libreoffice.LibreOffice --writer"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom7/ binding "['<Control><Alt>w']"

    gsettings set $CUSTOM_KEYBINDING_SETTING/custom8/ name "Black Screen"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom8/ command "xset dpms force off"
    gsettings set $CUSTOM_KEYBINDING_SETTING/custom8/ binding "['<Control><Alt>b']"
}

directories_colors_bookmarks() {
    if [ "${ADD_DIRECTORIES_COLORS_BOOKMARKS}" != true ] ; then
        return 0
    fi
    log "adding directories (and aliases), Nemo accent-colors, and Nemo bookmarks..."
    
    GREEN_FOLDER=/usr/share/icons/Mint-Y/places/128@2x/folder.png
    PURPLE_FOLDER=/usr/share/icons/Mint-Y-Purple/places/128@2x/folder.png

    if [ ! -d ~/Projects ] ; then
        mkdir ~/Projects
    fi
    echo "file://$HOME/Projects" >> ~/.config/gtk-3.0/bookmarks
    ln -sf ~/Projects ~/Desktop/Projects
    gio set "file://$HOME/Projects" metadata::custom-icon "file://$GREEN_FOLDER"
    gio set "file://$HOME/Desktop/Projects" metadata::custom-icon "file://$GREEN_FOLDER"

    if [ ! -d ~/Documents/Screenshots ]; then
        mkdir ~/Documents/Screenshots
    fi
    echo "file://$HOME/Documents/Screenshots" >> ~/.config/gtk-3.0/bookmarks
    ln -sf ~/Documents/Screenshots ~/Desktop/Screenshots
    gio set "file://$HOME/Documents/Screenshots" metadata::custom-icon "file://$PURPLE_FOLDER"
    gio set "file://$HOME/Desktop/Screenshots" metadata::custom-icon "file://$PURPLE_FOLDER"
}

templates() {
    if [ "${ADD_TEMPLATES}" != true ] ; then
        return 0
    fi
    log "Adding LibreOffice, plain text templates..."
    
    cp -r assets/Templates/. ~/Templates
}

nemo_tweaks() {
    if [ "${ADD_NEMO_TWEAKS}" != true ] ; then
        return 0
    fi
    log "adding Nemo tweaks..."

    # modify context menu
    gsettings set org.nemo.preferences enable-delete false
    gsettings set org.nemo.preferences.menu-config selection-menu-make-link true

    # add to shortcuts to toolbar
    gsettings set org.nemo.preferences show-new-folder-icon-toolbar true
    gsettings set org.nemo.preferences show-open-in-terminal-toolbar true
}

xed_tweaks() {
    if [ "${ADD_XED_TWEAKS}" != true ] ; then
        return 0
    fi
    log "adding tweaks to Xed (text editor)..."

    gsettings set org.x.editor.preferences.editor display-line-numbers true
    gsettings set org.x.editor.preferences.editor scheme "cobalt"
}

account_picture() {
    if [ "${SET_ACCOUNT_PICTURE}" != true ] ; then
        return 0
    fi
    log "Setting user account picture..."

    cp /usr/share/cinnamon/faces/3_sky.jpg ~/.face

    OLD_PATH="/home/$(whoami)/.face"
    NEW_PATH="/usr/share/cinnamon/faces/3_sky.jpg"

    for file in /var/lib/AccountsService/users/$(whoami) ; do
        sudo sed -i "s@$OLD_PATH@$NEW_PATH@g" "$file"
    done
}

# ============================================================================
# Main
# ============================================================================
set -e # exit immediately if a command exits with a non-zero status.

greeting_function
version_check
sudo -v

fastly_repo
timeshift_initialization
update_upgrade_apt

purge_apt_easy
install_apt_easy
install_flatpak_easy

extra_fonts
ttf_fonts
vscode
zoom_with_mods
ttr
kolourpaint_with_mods
firefox_esr_purge_stable_with_mods
libreoffice_flatpak_purge_apt
chromium_with_mods
virtualbox_with_ext_pack

login_window
screenshot_save_location
cinnamon_gtk_theme
wallpaper_slideshow
workspace_switcher_applet
date_format
cinnamenu_applet
desktop_files
keyboard_shortcuts
directories_colors_bookmarks
templates
nemo_tweaks
xed_tweaks
account_picture

update_upgrade_apt
timeshift_snapshot
exit_function
