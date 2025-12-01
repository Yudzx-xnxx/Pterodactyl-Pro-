#!/bin/bash
set -e

ID="$1"

echo "🔄 Uninstall Protect $ID..."

# ===========================================
#  MASUKKAN APA YANG PERLU DIHAPUS DISINI  
# ===========================================
case "$ID" in
    1)
        # Contoh: restore file asli
        rm -f /var/www/pterodactyl/resources/scripts/server-delete-protect.php
        echo "✔ Uninstall 1 selesai."
    ;;

    2)
        rm -f /var/www/pterodactyl/resources/scripts/user-delete-protect.php
        echo "✔ Uninstall 2 selesai."
    ;;

    3)
        rm -f /var/www/pterodactyl/resources/scripts/allocation-protect.php
        echo "✔ Uninstall 3 selesai."
    ;;

    4)
        rm -f /var/www/pterodactyl/resources/scripts/nodes-protect.php
        echo "✔ Uninstall 4 selesai."
    ;;

    5)
        rm -f /var/www/pterodactyl/resources/scripts/nest-protect.php
        echo "✔ Uninstall 5 selesai."
    ;;

    6)
        rm -f /var/www/pterodactyl/resources/scripts/settings-protect.php
        echo "✔ Uninstall 6 selesai."
    ;;

    7)
        rm -f /var/www/pterodactyl/resources/scripts/server-lock-1.php
        echo "✔ Uninstall 7 selesai."
    ;;

    8)
        rm -f /var/www/pterodactyl/resources/scripts/server-lock-2.php
        echo "✔ Uninstall 8 selesai."
    ;;

    9)
        rm -f /var/www/pterodactyl/resources/scripts/server-modify-protect.php
        echo "✔ Uninstall 9 selesai."
    ;;

    10|11|12|13|14|15)
        echo "ℹ Protect $ID belum diisi path uninstall."
    ;;

    *)
        echo "❌ ID uninstall tidak valid."
        exit 1
    ;;
esac

echo "🔁 Restarting panel..."
cd /var/www/pterodactyl && php artisan optimize:clear

echo "✅ Uninstall Protect $ID complete."
