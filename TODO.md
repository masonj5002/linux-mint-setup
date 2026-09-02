# Todo

## Requirements

- [ ] Modulize each component

## Initialization

- [ ] abort if mint version does not match
- [X] gain `sudo` access
- [X] set repo to Fastly
- [X] create `apt update` and `apt upgrade function`

## Application Install & Configurations

### Installs from Base Repos

- [X] `ttf-mscorefonts-installer`
- [X] `git`
- [X] `font-manager`
- [X] `neofetch`
- [X] `htop`
- [X] `steam-installer`

#### Installs from repos complex

- [X] Firefox ESR (PPA)
  - [X] purge Firefox
  - [X] enable Firefox Smooth Scrolling
  - [X] disable backspace to go back & front space to go forward
- [ ] Chromium
  - [X] Make Chromium default PDF viewer
  - [ ] set Chromium settings & install extensions via policy
    - [ ] policies
      - [X] disable request to be default browser
      - [X] clear all cookies & cache on exit
      - [ ] set home page (to new tab)
      - [ ] set search engine (from Yahoo! to DuckDuckGo)
      - [ ] modify bookmarks to empty list
      - [ ] disable autofill, password manager
      - [ ] extensions
        - [ ] blank new tab page
        - [ ] privacy badger
      - [ ] themes
        - [ ] classic blue
      - [ ] hide top bar
- [X] VSCode (install repo)
- [X] Zoom (use .deb)
  - [https://zoom.us/client/latest/zoom_amd64.deb]
  - [X] disable zoom mini-viewer
- [ ] VirtualBox (install repo)

### Flatpak Installs

- [X] Emote
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

- [ ] Switch color scheme to 'Aqua'
- [X] purge `cups-browsed`
- [X] Set `gnome-screenshot` save location
- [ ] Set wallpaper
- [ ] install Cinnamenu & move to corner
  - [ ] remove mint menu from bottom bar
- [ ] place 'Workspace switcher' on bottom bar
- [ ] remove 'Delete' and add 'Make Alias' to nemo context menu
- [ ] Create directory ~/Projects and create an alias on ~/Desktop
- [ ] Cleanup maintenance: including `sudo apt clean && sudo apt autoremove`
- [ ] enable timeshift

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

- [ ] install latest virtualbox from oracle (for 24.04)
- [ ] Firefox Smooth scrolling configs
- [ ] add `flathub` specifier to `flatpak install scripts`
- [ ] modify `.desktop` files to modify icons and enable fast searches
  - [ ] "Software Manager" -- add "(Store)" in description
  - [ ] add themed icons for flatpaks

``` bash
MOZ_USE_XINPUT2=1 | sudo tee /etc/profile.d/use-xinput2.sh
```

``` bash
flatpak override --user --env=GTK_THEME=Adwaita:light org.kde.kolourpaint
```


- [ ] Change default save screenshot location to ~/Documents/Screenshots

``` bash
gsettings set org.gnome.gnome-screenshot auto-save-directory "file:///home/mason/Documents/Screenshots"
```

- [ ] Set specific Desktop wallpaper (single photo or slideshow)
