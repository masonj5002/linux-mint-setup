# Todo

## Requirements

- [ ] Modulize each component
- [ ] * I want a clipboard manager
- [ ] * I want a way to get text messages (and/or imessage(s)) on my laptop

## Initialization

- [X] abort if mint version does not match
- [X] script runs only if in script directory
- [X] gain `sudo` access
- [X] set repo to Fastly
- [X] create `apt update` and `apt upgrade function`

## Application Install & Configurations

### Installs from Base Repos

- [X] `ttf-mscorefonts-installer`
  - [X] auto agree to EULA
- [X] `git`
  - [O] Establish git default user name and e-mail
- [X] `font-manager`
- [X] `neofetch`
- [X] `htop`
- [X] `steam-installer`

#### Installs from repos complex

- [X] Firefox ESR (PPA)
  - [X] purge Firefox
  - [X] enable Firefox Smooth Scrolling
  - [X] disable backspace to go back & front space to go forward (apparently already enabled?)
  - [X] configure Firefox `policies.json` file
  - [X] configure Firefox advanced configs in user.js
  - [X] fix printer margins in print-to-pdf
  - [X] replace `firefox` with `firefox-esr` in applet
  - [X] remove `mint-chat` (matrix) `.desktop` file
- [X] Chromium
  - [X] Make Chromium default PDF viewer
  - [X] set Chromium settings & install extensions via policy
    - [X] policies
      - [X] disable request to be default browser
      - [X] clear all cookies & cache on exit
      - [X] set home page (to new tab)
      - [X] set search engine (from Yahoo! to DuckDuckGo)
      - [X] modify bookmarks to empty list
      - [X] hide bookmarks bar
      - [X] disable autofill
      - [X] disable password manager
      - [X] extensions
        - [X] blank new tab page
        - [X] privacy badger
      - [X] themes
        - [X] classic blue
      - [O] hide top bar
      - [O] create a set list of bookmarks (i.e. "Clear Browsing Data")
- [X] VSCode (install repo)
- [X] Zoom (use .deb)
  - [https://zoom.us/client/latest/zoom_amd64.deb]
  - [X] disable zoom mini-viewer
- [X] VirtualBox (install repo, currently version 7.2)
  - [X] add current user to `vboxusers`
  - [X] download and install extension pack
- [O] Android Studio (install to `/opt/`, add `.desktop` file)

### Flatpak Installs

- [X] Emote (*add launch on startup, if needed?*)
- [X] Spotify
- [X] Flatseal
- [X] Authenticator
- [X] Shortwave
- [X] Blanket
- [X] KClock
- [X] Discord
- [X] AisleRiot
- [X] Gnome Chess
- [X] LocalSend
- [X] com.github.unrud.VideoDownloader

#### Complex Flatpak installs

- [X] Toontown Rewritten (add flatpak repo)
- [ ] Bottles
  - [ ] Wizard101 (separate function, attached to bottles)
- [X] KolourPaint
  - [X] force light theme
- [X] LibreOffice
  - [X] `purge` apt version and install flatpak version of `libreoffice*`
  - [X] add correct `.desktop` icons, theme them and hide others
    - [X] hide LibreOffice Math from 'Science' category

## Additional Configuration & Tweaks

- [X] Switch color scheme to 'Teal' and 'Dark Teal'
- [X] purge `cups-browsed`
- [X] Set `gnome-screenshot` save location
- [X] Set wallpaper -- set to directory
- [X] Cinnamenu
  - [X] import Cinnamenu preferences
    - [X] set custom icon logo, size, label
    - [X] set Cinnamon "Favorite Apps" list
  - [X] install Cinnamenu & move to corner
    - [X] add Cinnamenu and remove mint menu from bottom bar
- [X] place 'Workspace switcher' on bottom bar
  - [X] basic functionality
  - [X] swap `cinnamenu_applet` and `workspace_switcher_applet` order
  - [X] set number of workspaces to 2
- [X] Directories
  - [X] Create directory ~/Projects
  - [X] Set accent colors for 'Screenshots', 'Projects'
  - [X] Bookmark and add alias to desktop for 'Screenshots', 'Projects'
- [X] Add templates to template folder
- [X] Nemo
  - [X] remove 'Delete' from context menu
  - [X] add 'Make Alias' to context menu
  - [X] add 'New Folder', 'Open in Terminal' to context menu
- [X] Xed
  - [X] enable line numbers by default
  - [X] make `xed` open in a new window *every* time
- [X] add user-based `.desktop` files in `~/.local/share/applications`
- [X] Open new windows in 'center' as opposed to 'automatic'
- [X] enable timeshift and add scheduled snapshots
- [X] date format
  - [X] set panel clock to EN-US Windows 10-type date format
  - [X] set login screen to EN_US time format
- [X] Login window: enable numlockx
- [ ] create `.hidden` file for home directory
- [X] set icon list for grouped window panel
- [X] cleanup maintenance: including `sudo apt clean && sudo apt autoremove`

### Keyboard Shortcuts

- [X] set keyboard shortcuts below

``` bash
firefox              --> CTRL + ALT + F
nemo                 --> CTRL + ALT + N
gnome-system-monitor --> CTRL + SHIFT + ESC
chromium             --> CTRL + ALT + C
code                 --> CTRL + ALT + V
spotify-client       --> CTRL + ALT + S
discord              --> CTRL + ALT + D
LibreOffice Writer   --> CTRL + ALT + W

Black Screen         --> CTRL + ALT + B

fullscreen -mode     --> ALT + F                
minimize             --> ALT + A                ✅
always-on-top        --> 'Settings' key # Alt + Q

```

## Misc

``` bash
nano ~/.config/zoomus.conf
set enableMiniWindow=false
```

- [X] add `flathub` specifier to `flatpak install scripts`
- [X] modify `.desktop` files
  - [X] 'Software Manager' -- add "(Store)" in description
  - [X] 'Blanket'
  - [X] 'Zoom'
  - [X] 'Printers'
  - [X] hide 'Drawing'
  - [S] themed icons for flatpak(s):
    - [X] Kolourpaint
    - [O] Authenticator
    - [X] Clock
    - [X] Video Downloader
- [X] `cinnamon-gtk-theme`
  - [X] set nemo desktop font to 'Ubuntu Bold 12'
  - [X] disable 'use overlay scrollbars'
- [O] switch all flatpak installs to non-interactive, force progress bar
- [X] add user account picture
- [X] disable `font-manager` install by default
- [X] move configurable options to separate file
- [ ] move variables to top to follow best practice
- [ ] publish finalized release beta on GitHub (version 0.8)?
- Basic VSCODE Settings
  - [ ] Disable AI
  - [ ] Restore native toolbar
  - [ ] No overlay scroll bar
  - [ ] big tab horizontal scrollbar

``` bash
MOZ_USE_XINPUT2=1 | sudo tee /etc/profile.d/use-xinput2.sh
```

``` bash
flatpak override --user --env=GTK_THEME=Adwaita:light org.kde.kolourpaint
```

``` bash
gsettings set org.gnome.gnome-screenshot auto-save-directory "file:///home/mason/Documents/Screenshots"
```

``` bash
# changing cinnamon desktop fonts
gsettings get org.cinnamon.desktop.interface grouped_window_list_appletfont-name
gsettings get org.nemo.desktop font
gsettings get org.gnome.desktop.interface document-font-name
gsettings get org.gnome.desktop.interface monospace-font-name
gsettings get org.cinnamon.desktop.wm.preferences titlebar-font
gsettings get org.cinnamon.desktop.interface text-scaling-factor
```

``` bash
jq --arg jq_var ${bash_var} [options...] filter [files ...]
```

- [ ] *In the future, explore different linux mint system fonts*
- [ ] fix the version check so that it returns 1 instead of exiting...
- *on mint 23, switch `neofetch` to `fastfetch`, if not already installed*
