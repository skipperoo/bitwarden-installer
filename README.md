# Bitwarden AppImage Installer

Encountering various issues wit both the [`flatpak`](https://flathub.org/apps/com.bitwarden.desktop) (experiencing UI blurriness on HiDPI displays) and the [`snap`](https://snapcraft.io/bitwarden) (encountering keyboard input issues) packages, I decide to make my own installation script to fetch the latest `AppImage` package from the [official website](https://bitwarden.com/), which has always been the most reliable way to use Bitwarden on my system.

## Usage

Simply run the following command in your terminal to execute the installation script:
```bash
curl -sSL https://raw.githubusercontent.com/skiby7/bitwarden-installer/master/install-bitwarden.sh | bash
```

This script will automatically download the latest Bitwarden desktop version and generate a corresponding `.desktop` file under `/usr/share/applications`, ensuring seamless integration with your app launcher.

Feel free to contribute, report issues, or provide feedback.