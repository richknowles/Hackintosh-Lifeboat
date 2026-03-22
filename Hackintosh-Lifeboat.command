#!/bin/bash

# --- CONFIGURATION ---
BACKUP_DIR="$HOME/WasabiDrive"
mkdir -p "$BACKUP_DIR"

# --- TUI HELPERS ---
NORMAL=$(tput sgr0)
BOLD=$(tput bold)
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)

header() {
    clear
    echo "${CYAN}${BOLD}=========================================="
    echo "       HACKINTOSH LIFEBOAT v1.0"
    echo "==========================================${NORMAL}"
    echo
}

# --- MAIN LOGIC ---
header
echo "${BOLD}Available External Drives:${NORMAL}"
diskutil list external physical | grep -E "/dev/disk|NAME|SIZE"
echo

echo -n "${BOLD}Enter the disk identifier (e.g., disk3): ${NORMAL}"
read DISK_ID

if [[ ! $DISK_ID =~ ^disk[0-9]+$ ]]; then
    echo "${RED}Error: Invalid disk ID.${NORMAL}"
    exit 1
fi

TARGET_DISK="/dev/$DISK_ID"
RAW_DISK="/dev/r$DISK_ID"
FILENAME="Hackintosh_Backup_$(date +%Y-%m-%d).img.gz"
DESTINATION="$BACKUP_DIR/$FILENAME"

header
echo "${BOLD}Target:${NORMAL} $TARGET_DISK"
echo "${BOLD}Backup Path:${NORMAL} $DESTINATION"
echo
echo "${RED}${BOLD}WARNING:${NORMAL} This will read the entire disk. Please ensure you have sudo rights."
echo -n "Press [ENTER] to start or [Ctrl+C] to abort..."
read

# Validate sudo early
sudo -v

header
echo "${CYAN}Unmounting $TARGET_DISK...${NORMAL}"
diskutil unmountDisk "$TARGET_DISK"

echo "${GREEN}Starting backup... (Press Ctrl+T for status)${NORMAL}"
# If 'pv' is installed, use it; otherwise fall back to raw dd
if command -v pv >/dev/null 2>&1; then
    sudo dd if="$RAW_DISK" bs=1m | pv -s 31G | gzip -c > "$DESTINATION"
else
    echo "Note: Install 'pv' via brew for a live progress bar."
    sudo dd if="$RAW_DISK" of="$DESTINATION" bs=1m status=progress | gzip -c > "$DESTINATION"
fi

header
if [ $? -eq 0 ]; then
    echo "${GREEN}${BOLD}SUCCESS!${NORMAL}"
    echo "Image saved to: $DESTINATION"
else
    echo "${RED}${BOLD}FAILURE!${NORMAL} Check your connection and WasabiDrive space."
fi

echo
echo "Press any key to exit..."
read -n 1
