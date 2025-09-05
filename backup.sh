# Script to backup important files that should be kept between reinstalls.
# Backup files are stored in "/mnt/storage/docs/linux/backup"; each group has its own folder.
# Backup executes every week via a systemd timer, but can also be executed manually before a reinstall.

set -e

## Make sure not running as root
if (($EUID == 0));
        then echo "Please run as regular user. Exiting."
        exit 1
fi

# Alias file groups
BASHRC="${HOME}/.bashrc"
BASH_ALIASES="${HOME}/.bash_aliases"
CONFIG_DIR="${HOME}/.config/"
#FIREFOX_PROFILE="${HOME}/.mozilla/*"
LIBREWOLF_PROFILE="${HOME}/.librewolf/*"
NANO_SETTINGS="${HOME}/.nanorc"
SYNCTHING_SETTINGS="${HOME}/.local/state/syncthing/*"
THUNDERBIRD_MAILBOX="${HOME}/.thunderbird/*"
SSH_KEYS="${HOME}/.ssh/*"

# cd into working directory
cd "/mnt/storage/docs/linux/backup"

# ~/.config contents desired for backup
CONFIG_ITEMS=(
    "autostart"
    "calibre"
    "discord"
    "foot"
    "geany"
    "GIMP"
    "jamesdsp"
    "keepassxc"
    "mpv"
    "MusicBrainz"
    "nautilus"
    "nicotine"
    "obs-studio"
    "OpenRGB"
    "qBittorrent"
    "streamlink"
    "systemd"
    "vesktop"
    "VNote"
    "VSCodium"
    "mimeapps.list"
    "user-dirs.dirs"
    "user-dirs.locale"
)

# Backup .config items
if [ ! -d ./CONFIG_ITEMS ]; then
    mkdir "CONFIG_ITEMS"
fi

echo -e "\033[0;33mBacking up .config items...\033[0;0m"
for item in "${CONFIG_ITEMS[@]}"
do
    rsync -auq ${CONFIG_DIR}${item} "CONFIG_ITEMS"
done

# Backup dotfiles
if [ ! -d ./DOT_FILES ]; then
    mkdir "DOT_FILES"
fi

echo -e "\033[0;33mBacking up dot files...\033[0;0m"
rsync -auq ${BASHRC} ${BASH_ALIASES} ${NANO_SETTINGS} "DOT_FILES"

# Backup Firefox Profile
#if [ ! -d ./FIREFOX_PROFILE ]; then
#    mkdir "FIREFOX_PROFILE"
#fi

# echo -e "\033[0;33mBacking up Firefox profile...\033[0;0m"
# rsync -auq ${FIREFOX_PROFILE} "FIREFOX_PROFILE"

# Backup Librewolf Profile
if [ ! -d ./LIBREWOLF_PROFILE ]; then
    mkdir "LIBREWOLF_PROFILE"
fi

echo -e "\033[0;33mBacking up Librewolf profile...\033[0;0m"
rsync -auq ${LIBREWOLF_PROFILE} "LIBREWOLF_PROFILE"

# Backup Syncthing Settings
if [ ! -d ./SYNCTHING_SETTINGS ]; then
    mkdir "SYNCTHING_SETTINGS"
fi

echo -e "\033[0;33mBacking up Syncthing settings...\033[0;0m"
rsync -auq ${SYNCTHING_SETTINGS} "SYNCTHING_SETTINGS"

# Backup Thunderbird Mailbox
if [ ! -d ./THUNDERBIRD_MAILBOX ]; then
    mkdir "THUNDERBIRD_MAILBOX"
fi

echo -e "\033[0;33mBacking up Thunderbird mailbox...\033[0;0m"
rsync -auq ${THUNDERBIRD_MAILBOX} "THUNDERBIRD_MAILBOX"

# Backup SSH Keys
if [ ! -d ./SSH_KEYS ]; then
    mkdir "SSH_KEYS"
fi

echo -e "\033[0;33mBacking up SSH Keys...\033[0;0m"
rsync -auq ${SSH_KEYS} "SSH_KEYS"

# Sync all changes to hard disk
echo -e "\033[0;33mSyncing changes...\033[0;0m"
sync

# Done
echo -e "\033[0;32mBackup complete.\033[0;0m"
