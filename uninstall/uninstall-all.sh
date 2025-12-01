#!/bin/bash

REMOTE_PATH="/var/www/pterodactyl/app/Http/Controllers/Admin/Nodes/NodeController.php"
BACKUP_DIR="/var/backups/pterodactyl/nodes"

echo "🧹 Uninstall SEMUA Proteksi Detail Nodes"

# Cari backup terbaru
LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/NodeController.php.BACKUP-* 2>/dev/null | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "❌ Tidak ada file backup ditemukan!"
    exit 1
fi

echo "🔍 Backup terbaru ditemukan:"
echo "📦 $LATEST_BACKUP"

sleep 1

echo "🔄 Memulihkan file asli..."
cp "$LATEST_BACKUP" "$REMOTE_PATH"

echo "🔐 Set permission..."
chmod 644 "$REMOTE_PATH"

echo "🗑️ Menghapus *semua* backup lain..."
find "$BACKUP_DIR" -type f -name "NodeController.php.BACKUP-*" ! -name "$(basename "$LATEST_BACKUP")" -delete

echo "✅ Semua proteksi dicopot!"
echo "📂 File dipulihkan dari: $LATEST_BACKUP"