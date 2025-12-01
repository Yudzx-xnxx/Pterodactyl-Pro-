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

    case $P in
        1) bash <(curl -sSL "$REPO/install/installprotect1.sh") ;;
        2) bash <(curl -sSL "$REPO/install/installprotect2.sh") ;;
        3) bash <(curl -sSL "$REPO/install/installprotect3.sh") ;;
        4) bash <(curl -sSL "$REPO/install/installprotect4.sh") ;;
        5) bash <(curl -sSL "$REPO/install/installprotect5.sh") ;;
        6) bash <(curl -sSL "$REPO/install/installprotect6.sh") ;;
        7) bash <(curl -sSL "$REPO/install/installprotect7.sh") ;;
        8) bash <(curl -sSL "$REPO/install/installprotect8.sh") ;;
        9) bash <(curl -sSL "$REPO/install/installprotect9.sh") ;;
        10)
            echo "🚀 Installing ALL protections..."
            for i in {1..9}; do
                bash <(curl -sSL "$REPO/install/installprotect$i.sh")
            done
            echo "✅ ALL protections installed!"
            ;;
        *)
            echo "❌ Menu tidak valid."
            ;;
    esac
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

    case $U in
        1) bash <(curl -sSL "$REPO/uninstall/uninstallprotect1.sh") ;;
        2) bash <(curl -sSL "$REPO/uninstall/uninstallprotect2.sh") ;;
        3) bash <(curl -sSL "$REPO/uninstall/uninstallprotect3.sh") ;;
        4) bash <(curl -sSL "$REPO/uninstall/uninstallprotect4.sh") ;;
        5) bash <(curl -sSL "$REPO/uninstall/uninstallprotect5.sh") ;;
        6) bash <(curl -sSL "$REPO/uninstall/uninstallprotect6.sh") ;;
        7) bash <(curl -sSL "$REPO/uninstall/uninstallprotect7.sh") ;;
        8) bash <(curl -sSL "$REPO/uninstall/uninstallprotect8.sh") ;;
        9) bash <(curl -sSL "$REPO/uninstall/uninstallprotect9.sh") ;;
        10)
            bash <(curl -sSL "$REPO/uninstall/uninstall-all.sh")
            ;;
        *)
            echo "❌ Menu tidak valid."
            ;;
    esac
fi

# ==========================================================
if [[ "$MAIN" == "3" ]]; then
    echo "👋 Keluar..."
    exit 0
fi