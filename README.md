# Bitwarden AppImage Installer

Since I encountered many bugs while using both the [`flatpak`](https://flathub.org/apps/com.bitwarden.desktop) (the UI is blurry on HiDPI displays) and the [`snap`](https://snapcraft.io/bitwarden) (keyboard input not working) packages, I decide to make my own installation script to fetch the latest `AppImage` package from the [official website](https://bitwarden.com/).

This script downloads the latest version of Bitwarden desktop, and creates a `.desktop` file under `/usr/share/applications`, so that the application shows up in the app launcher.

## Usage

To run the script enter this command in the terminal:

```bash
curl -sSL https://raw.githubusercontent.com/skiby7/bitwarden-installer/master/install-bitwarden.sh | bash
```