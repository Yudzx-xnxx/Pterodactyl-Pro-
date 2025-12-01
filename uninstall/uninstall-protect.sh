#!/bin/bash

BACKUP_DIR="/root/yudzxtech-backups"
BASE_PTERO="/var/www/pterodactyl"

declare -A FILES=(
    [1]="$BASE_PTERO/app/Http/Controllers/Admin/Servers/ServerController.php"
    [2]="$BASE_PTERO/app/Http/Controllers/Admin/Servers/DatabaseController.php"
    [3]="$BASE_PTERO/app/Http/Controllers/Admin/Nodes/NodeViewController.php"
    [4]="$BASE_PTERO/app/Http/Controllers/Admin/Nodes/SystemInformationController.php"
    [5]="$BASE_PTERO/app/Http/Controllers/Admin/Nodes/NodeController.php"
    [6]="$BASE_PTERO/app/Http/Controllers/Admin/Allocations/AllocationController.php"
    [7]="$BASE_PTERO/app/Http/Controllers/Admin/Servers/ServerTransferController.php"
    [8]="$BASE_PTERO/app/Http/Controllers/Admin/Servers/ServerViewController.php"
    [9]="$BASE_PTERO/app/Http/Controllers/Admin/Nests/NestController.php"
    [10]="$BASE_PTERO/app/Http/Controllers/Admin/Users/UserController.php"
    [11]="$BASE_PTERO/app/Http/Controllers/Admin/Settings/SettingsController.php"
    [12]="$BASE_PTERO/app/Http/Controllers/Admin/Locations/LocationController.php"
    [13]="$BASE_PTERO/app/Http/Controllers/Admin/Nodes/NodeAutoDeployController.php"
    [14]="$BASE_PTERO/app/Http/Controllers/Admin/Servers/ServerDeletionController.php"
    [15]="$BASE_PTERO/app/Http/Controllers/Admin/Servers/SuspensionController.php"
)

ASCII="
╔═════════════════════════════════════╗
║ 🔧 YudzxTech — Protect Uninstaller  ║
║   Telegram: t.me/Yudzxcysec         ║
╚═════════════════════════════════════╝
"

clear
echo "$ASCII"
echo "Pilih proteksi yang ingin dihapus:"
echo ""

for i in {1..15}; do
    echo "[$i] Uninstall Protect $i"
done

echo "[99] Uninstall Semua Proteksi"
echo ""
read -p "Masukkan pilihan: " PIL

uninstall_single() {
    local id=$1
    local TARGET="${FILES[$id]}"
    local BACKUP="$BACKUP_DIR/protect${id}.backup.php"

    echo ""
    echo "⏳ Menghapus Proteksi $id..."

    if [[ ! -f "$BACKUP" ]]; then
        echo "❌ Backup tidak ditemukan! Tidak bisa uninstall Proteksi $id!"
        return
    fi

    cp "$BACKUP" "$TARGET"
    chmod 644 "$TARGET"

    echo "✅ Proteksi $id berhasil dihapus!"
}

uninstall_all() {
    for id in {1..15}; do
        uninstall_single $id
    done
    echo ""
    echo "🎉 Semua proteksi berhasil dihapus!"
}

case $PIL in
    1|2|3|4|5|6|7|8|9|10|11|12|13|14|15)
        uninstall_single $PIL
        ;;
    99)
        uninstall_all
        ;;
    *)
        echo "❌ Pilihan tidak dikenal!"
        ;;
esac