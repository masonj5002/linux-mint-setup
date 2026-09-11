# Todo

## Requirements

- [ ] Modulize each component

## Initialization

- [X] abort if mint version does not match
- [ ] script only runs if script is in current directory (or similar fix)
- [X] gain `sudo` access
- [X] set repo to Fastly
- [X] create `apt update` and `apt upgrade function`

## Application Install & Configurations

### Installs from Base Repos

- [X] `ttf-mscorefonts-installer`
  - [X] auto agree to EULA
- [X] `git`
  - [ ] Establish git default user name and e-mail
- [X] `font-manager`
- [X] `neofetch`
- [X] `htop`
- [X] `steam-installer`

#### Installs from repos complex

- [ ] Firefox ESR (PPA)
  - [X] purge Firefox
  - [X] enable Firefox Smooth Scrolling
  - [X] disable backspace to go back & front space to go forward
  - [ ] add `firefox-esr` to "taskbar"
  - [ ] prevent `mint-chat` (matrix) from being removed
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
      - [ ] create a set list of bookmarks (i.e. "Clear Browsing Data")
- [X] VSCode (install repo)
- [X] Zoom (use .deb)
  - [https://zoom.us/client/latest/zoom_amd64.deb]
  - [X] disable zoom mini-viewer
- [X] VirtualBox (install repo, currently version 7.2)
  - [X] add current user to `vboxusers`
  - [X] download and install extension pack
- [ ] Android Studio (install to `/opt/`, add `.desktop` file)

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
  - [ ] add correct `.desktop` icons, theme them and hide others

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
- [ ] place 'Workspace switcher' on bottom bar
  - [X] basic functionality
  - [X] swap `cinnamenu_applet` and `workspace_switcher_applet` order
  - [X] set number of workspaces to 2
- [ ] remove 'Delete' and add 'Make Alias' to nemo context menu
- [ ] Create directory ~/Projects and create an alias on ~/Desktop
- [ ] enable timeshift and add scheduled snapshots
- [ ] Add templates to template folder
- [ ] make `xed` open in a new window *every* time
- [ ] Cleanup maintenance: including `sudo apt clean && sudo apt autoremove`
- [ ] modify `.desktop` files
- [ ] Open new windows in 'center' as opposed to 'automatic'

### Keyboard Shortcuts

- [ ] set keyboard shortcuts

``` bash
fullscreen -mode     --> ALT + F
gnome-system-monitor --> CTRL + SHIFT + ESC
nemo                 --> CTRL + ALT + N
firefox              --> CTRL + ALT + F
chromium             --> CTRL + ALT + C
code                 --> CTRL + ALT + V
spotify-client       --> CTRL + ALT + S
discord              --> CTRL + ALT + D
LibreOffice Writer   --> CTRL + ALT + W
always-on-top        --> 'Settings' key
```

## Misc

``` bash
nano ~/.config/zoomus.conf
set enableMiniWindow=false
```

- [X] add `flathub` specifier to `flatpak install scripts`
- [ ] modify `.desktop` files to modify icons and enable fast searches
  - [ ] "Software Manager" -- add "(Store)" in description
  - [ ] add themed icons for some flatpak(s)
  - [ ] move variables to top to follow best practice
  - [ ] move configurable options to separate file

``` bash
MOZ_USE_XINPUT2=1 | sudo tee /etc/profile.d/use-xinput2.sh
```

``` bash
flatpak override --user --env=GTK_THEME=Adwaita:light org.kde.kolourpaint
```

``` bash
gsettings set org.gnome.gnome-screenshot auto-save-directory "file:///home/mason/Documents/Screenshots"
```
