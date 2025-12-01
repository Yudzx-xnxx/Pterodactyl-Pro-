#!/bin/bash

REMOTE_PATH="/var/www/pterodactyl/app/Http/Controllers/Admin/Nodes/NodeController.php"
BACKUP_DIR="/var/backups/pterodactyl/nodes"

echo "🧹 Uninstall Proteksi Detail Nodes (Mode 1-15)"

read -p "Masukkan nomor backup (1–15): " NUM

BACKUP_FILE="$BACKUP_DIR/NodeController.php.BACKUP-$NUM.bak"

# Cek backup
if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Backup tidak ditemukan: $BACKUP_FILE"
    exit 1
fi

echo "🔄 Restore file asli..."
cp "$BACKUP_FILE" "$REMOTE_PATH"

echo "🔐 Set permission..."
chmod 644 "$REMOTE_PATH"

echo "✅ Restore selesai!"
echo "📂 File dikembalikan dari: $BACKUP_FILE"