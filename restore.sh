# Restores files from "/mnt/storage/docs/linux/backup" into their appropriate places.

## Make sure not running as root
if (($EUID == 0));
        then echo "Please run as regular user. Exiting."
        exit 1
fi

set -e

# Alias file groups
BASHRC="${HOME}/.bashrc"
BASH_ALIASES="${HOME}/.bash_aliases"
CONFIG_DIR="${HOME}/.config/"
FIREFOX_PROFILE="${HOME}/.mozilla/*"
LIBREWOLF_DIR="${HOME}/.librewolf"
LIBREWOLF_PROFILE="${HOME}/.librewolf/*"
SYNCTHING_DIR="${HOME}/.local/state/syncthing"
SYNCTHING_SETTINGS="${HOME}/.local/state/syncthing/*"
THUNDERBIRD_DIR="${HOME}/.thunderbird"
THUNDERBIRD_MAILBOX="${HOME}/.thunderbird/*"
SSH_DIR="${HOME}/.ssh"
SSH_KEYS="${HOME}/.ssh/*"

cd "/mnt/storage/docs/linux/backup"

CONFIG_ITEMS=$('ls' CONFIG_ITEMS)

# Restore .bashrc and .bash_aliases
if [ -e "${BASHRC}" ]; then
    rm "${BASHRC}"
fi

if [ -e "${BASH_ALIASES}" ]; then
    rm "${BASH_ALIASES}"
fi

echo -e "\033[0;33mRestoring .bashrc and .bash_aliases...\033[0;0m"
cp -r DOT_FILES/.* "${HOME}"

# Restore .config folders and files
echo -e "\033[0;33mRestoring .config files and folders...\033[0;0m"
cp -r CONFIG_ITEMS/* "${CONFIG_DIR}"

# Restore Librewolf profile
echo -e "\033[0;33mRestoring Librewolf profile...\033[0;0m"
if [ ! -d ".librewolf" ]; then
    mkdir "${LIBREWOLF_DIR}"
fi
cp -r LIBREWOLF_PROFILE/* "${LIBREWOLF_DIR}"

# Restore Syncthing Settings
echo -e "\033[0;33mRestoring Syncthing settings...\033[0;0m"
if [ ! -d "${SYNCTHING_DIR}" ]; then
    mkdir "${SYNCTHING_DIR}"
fi
cp -r SYNCTHING_SETTINGS/* "${SYNCTHING_DIR}"

# Restore Thunderbird Mailbox
echo -e "\033[0;33mRestoring Thunderbird mailbox...\033[0;0m"
if [ ! -d "${THUNDERBIRD_DIR}" ]; then
    mkdir "${THUNDERBIRD_DIR}"
fi
cp -r THUNDERBIRD_MAILBOX/* "${THUNDERBIRD_DIR}"

# Restore SSH Keys
echo -e "\033[0;33mRestoring SSH keys...\033[0;0m"
if [ ! -d "${SSH_DIR}" ]; then
    mkdir "${SSH_DIR}"
fi
cp -r SSH_KEYS/* "${SSH_DIR}"

echo -e "\033[0;32mRestore complete.\033[0;0m"
