# Todo

## Requirements

- [ ] Modulize each component

## Initialization

- [ ] abort if mint version does not match
- [ ] gain `sudo` access
- [ ] set repo to Fastly
- [ ] `sudo apt update && sudo apt upgrade -y`

## Application Install & Configurations

### Installs from Base Repos

- [ ] Firefox ESR
  - [ ] purge Firefox
  - [ ] enable Firefox Smooth Scrolling
- [ ] Chromium
  - [ ] set Chromium settings & install extensions via policy
- [ ] `ttf-mscorefonts-installer`
- [ ] `git`
- [ ] `font-manager`
- [ ] `neofetch`
- [ ] `htop`
- [ ] Steam

### Flatpak Installs

- [ ] Emote
- [ ] Spotify
- [ ] Flatseal
- [ ] Authenticator
- [ ] Shortwave
- [ ] Blanket
- [ ] KClock
- [ ] Discord
- [ ] AisleRiot
- [ ] Gnome Chess
- [ ] LocalSend
- [ ] com.github.unrud.VideoDownloader
- [ ] Bottles
  - [ ] Wizard101
- [ ] Toontown Rewritten
- [ ] KolourPaint
  - [ ] force light theme

### External Installs

- [ ] VSCode
- [ ] Zoom
  - [ ] if still buggy, disable zoom mini-viewer
- [ ] VirtualBox

## Additional Configuration & Tweaks

- [ ] Switch color scheme to 'Aqua'
- [ ] purge `cups-browsed`
- [ ] Set `gnome-screenshot` save location
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
