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

#### Installs from base repos complex

- [ ] Firefox ESR (PPA)
  - [ ] purge Firefox
  - [ ] enable Firefox Smooth Scrolling
  - [ ] disable backspace to go back & front space to go forward
- [ ] Chromium
  - [ ] Make Chromium default PDF viewer
  - [ ] set Chromium settings & install extensions via policy

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
- [ ] KolourPaint
  - [ ] force light theme
- [ ] LibreOffice
  - [ ] `purge` apt version of `libreoffice*`

### External Installs

- [X] VSCode (install repo)
- [X] Zoom (use .deb)
  - [https://zoom.us/client/latest/zoom_amd64.deb]
  - [X] disable zoom mini-viewer
- [ ] VirtualBox (install repo)
- [ ] firefox-esr (see above, use PPA)

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

``` bash
MOZ_USE_XINPUT2=1 | sudo tee /etc/profile.d/use-xinput2.sh
```

- [ ] Fix KolourPaint theme by setting it to light

``` bash
flatpak override --user --env=GTK_THEME=Adwaita:light org.kde.kolourpaint
```


- [ ] Change default save screenshot location to ~/Documents/Screenshots

``` bash
gsettings set org.gnome.gnome-screenshot auto-save-directory "file:///home/mason/Documents/Screenshots"
```

- [ ] Set specific Desktop wallpaper (single photo or slideshow)
