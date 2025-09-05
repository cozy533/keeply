# keeply 📦

A set of Bash scripts for backing up and restoring important Linux configuration files and user data. Automates the process of preserving specified dotfiles, `.config` directories, browser profiles, application settings, and optionally SSH keys or emails. Designed for personal use.

## Scripts

### `backup.sh`

- Backs up important configuration files and directories, including:
  - Dotfiles: `.bashrc`, `.bash_aliases`, `.nanorc`
  - `.config` items (application settings)
  - Browser profiles (Librewolf, optional Firefox)
  - Syncthing settings
  - Thunderbird mailbox (optional)
  - SSH keys (optional)
- Organizes backups into dedicated folders in a central location (`/mnt/storage/docs/linux/backup`)  
- Can be run manually or automatically via systemd timers  
- Uses `rsync` for efficient, incremental backups  

### `restore.sh`

- Restores all backed-up files and directories to their original locations  
- Recreates missing directories if necessary  
- Preserves file structure and ownership  

## Installation

1. Clone the repository:
```
git clone https://github.com/cozy533/keeply
cd keeply
```

2. Make the scripts executable:
```
chmod +x backup.sh restore.sh
```

4. Optional: move scripts to a directory in `PATH` for easy access:
```
sudo mv backup.sh restore.sh /usr/local/bin/
```

## Usage
- Run a backup:
```
./backup.sh
```
- Restore from backup:
```
./restore.sh
```

## Notes & Security
>⚠️ **Designed for personal use.** <br>
If you choose to back up sensitive files such as SSH keys or emails, make sure to store the backup securely and maintain a safe copy. Do **not** share these files publicly.

## Requirements
- Bash shell
- `rsync` installed
- Standard Linux utilities (`cp`, `mkdir`, `sync`)
