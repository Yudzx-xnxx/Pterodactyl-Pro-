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
# ===================== HEADER NEOFETCH =====================
# ==========================================================
clear
if command -v neofetch >/dev/null 2>&1; then
    neofetch
fi

echo " "
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "           YudzxTech Protect Tool        "
echo "         Telegram: t.me/Yudzxcysec       "
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " "
echo " 1) Install Protect"
echo " 2) Uninstall Protect"
echo " 3) Exit"
echo " "
read -p "Pilih menu: " MAIN




# ==========================================================
# ======================= INSTALL MENU ======================
# ==========================================================
if [[ "$MAIN" == "1" ]]; then
    clear
    neofetch 2>/dev/null

    echo "┏╾─⧼ Install Protect Menu ⧽─╸"
    echo "│  1.  Anti Delete Server"
    echo "│  2.  Anti Delete User"
    echo "│  3.  Anti Intip Allocation"
    echo "│  4.  Anti Intip Nodes"
    echo "│  5.  Anti Intip Nest"
    echo "│  6.  Anti Intip Settings"
    echo "│  7.  Anti Akses Server (1)"
    echo "│  8.  Anti Akses Server (2)"
    echo "│  9.  Anti Modifikasi Detail Server"
    echo "│ 10.  Install Protect 10"
    echo "│ 11.  Install Protect 11"
    echo "│ 12.  Install Protect 12"
    echo "│ 13.  Install Protect 13"
    echo "│ 14.  Install Protect 14"
    echo "│ 15.  Install Protect 15"
    echo "│ 16.  Install ALL Protect"
    echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo " "
    read -p "Pilih proteksi: " P

    if [[ "$P" =~ ^[1-9]$|^1[0-5]$ ]]; then
        bash <(curl -sSL "$REPO/install/installprotect$P.sh")
        exit
    elif [[ "$P" == "16" ]]; then
        echo "🚀 Installing ALL Protects..."
        for i in {1..15}; do
            bash <(curl -sSL "$REPO/install/installprotect$i.sh")
        done
        echo "✅ Semua proteksi berhasil di-install!"
        exit
    else
        echo "❌ Menu tidak valid."
        exit
    fi
fi



# ==========================================================
# ====================== UNINSTALL MENU =====================
# ==========================================================
if [[ "$MAIN" == "2" ]]; then
    clear
    neofetch 2>/dev/null

    echo "┏╾─⧼ Uninstall Protect Menu ⧽─╸"
    echo "│  1–15. Uninstall protect per nomor"
    echo "│  16.   Uninstall ALL Protections"
    echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo " "
    read -p "Pilih uninstall: " U

    if [[ "$U" =~ ^[1-9]$|^1[0-5]$ ]]; then
        bash <(curl -sSL "$REPO/uninstall/uninstallprotect$U.sh")
        exit
    elif [[ "$U" == "16" ]]; then
        bash <(curl -sSL "$REPO/uninstall/uninstall-all.sh")
        exit
    else
        echo "❌ Menu tidak valid."
        exit
    fi
fi


# ==========================================================
# ========================== EXIT ===========================
# ==========================================================
if [[ "$MAIN" == "3" ]]; then
    echo "👋 Keluar..."
    exit 0
fi

echo "❌ Pilihan tidak valid."
exit 1
