#!/bin/bash

REPO="https://raw.githubusercontent.com/Yudzx-xnxx/Pterodactyl-Pro-/main"

clear

# ==========================================================
# ========== AUTO INSTALL NEOFETCH JIKA BELUM ADA ==========
# ==========================================================
if ! command -v neofetch >/dev/null 2>&1; then
    echo "📦 Neofetch tidak ditemukan. Menginstal..."

    if command -v apt >/dev/null 2>&1; then
        sudo apt update -y && sudo apt install neofetch -y
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install neofetch -y
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install neofetch -y
    else
        echo "⚠️  Tidak dapat menginstal neofetch secara otomatis."
        echo "    Melanjutkan tanpa neofetch..."
    fi
fi

# ==========================================================
# ========== TAMPILKAN NEOFETCH (JIKA ADA) ==================
# ==========================================================
if command -v neofetch >/dev/null 2>&1; then
    neofetch
fi


echo " "
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "        YudzxTech Protection Setup       "
echo "        Telegram: t.me/Yudzxcysec        "
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " "
echo "1) Install Protect"
echo "2) Uninstall Protect"
echo "3) Exit"
echo " "
read -p "Pilih menu: " MAIN


# ==========================================================
#      F U N G S I   A M A N   U N T U K   C U R L
# ==========================================================
safe_execute() {
    FILE_URL="$1"

    # cek apakah file benar-benar ada
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$FILE_URL")

    if [[ "$HTTP_CODE" == "200" ]]; then
        bash <(curl -sSL "$FILE_URL")
    else
        echo "❌ File tidak ditemukan: $FILE_URL"
        echo "   Pastikan file sudah diupload ke repo!"
        return 1
    fi
}



# ==========================================================
# ===============  INSTALL PROTECT SUBMENU  =================
# ==========================================================
if [[ "$MAIN" == "1" ]]; then
    clear
    neofetch 2>/dev/null

    echo "┏╾─⧼ Protect Menu ⧽─╸"
    echo "│ 1. Anti Delete Server"
    echo "│ 2. Anti Delete User"
    echo "│ 3. Anti Intip Allocation"
    echo "│ 4. Anti Intip Nodes"
    echo "│ 5. Anti Intip Nest"
    echo "│ 6. Anti Intip Settings"
    echo "│ 7. Anti Akses Server (1)"
    echo "│ 8. Anti Akses Server (2)"
    echo "│ 9. Anti Modifikasi Detail Server"
    echo "│ 10. Install ALL Protects"
    echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo " "
    read -p "Pilih proteksi: " P

    if [[ "$P" =~ ^[1-9]$ ]]; then
        safe_execute "$REPO/install/installprotect$P.sh"
    elif [[ "$P" == "10" ]]; then
        echo "🚀 Installing ALL protections..."
        for i in {1..9}; do
            safe_execute "$REPO/install/installprotect$i.sh"
        done
        echo "✅ ALL protections installed!"
    else
        echo "❌ Menu tidak valid."
    fi
fi



# ==========================================================
# ===============  UNINSTALL PROTECT SUBMENU  ===============
# ==========================================================
if [[ "$MAIN" == "2" ]]; then
    clear
    neofetch 2>/dev/null

    echo "┏╾─⧼ Uninstall Menu ⧽─╸"
    echo "│ 1–9. Uninstall protect per file"
    echo "│ 10. Uninstall ALL Protections"
    echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo " "
    read -p "Pilih uninstall: " U

    if [[ "$U" =~ ^[1-9]$ ]]; then
        safe_execute "$REPO/uninstall/uninstallprotect$U.sh"
    elif [[ "$U" == "10" ]]; then
        safe_execute "$REPO/uninstall/uninstall-all.sh"
    else
        echo "❌ Menu tidak valid."
    fi
fi


# ==========================================================
if [[ "$MAIN" == "3" ]]; then
    echo "👋 Keluar..."
    exit 0
fi
