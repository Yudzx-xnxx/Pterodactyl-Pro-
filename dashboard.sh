#!/bin/bash

# ==============================
#  AUTO INSTALL NEOFETCH
# ==============================
if ! command -v neofetch &> /dev/null; then
    echo "Menginstall Neofetch..."
    apt update -y >/dev/null 2>&1
    apt install neofetch -y >/dev/null 2>&1
fi

clear
neofetch --ascii_distro ubuntu

# ==============================
#  REPO DASAR
# ==============================
BASE_URL="https://raw.githubusercontent.com/Yudzx-xnxx/Pterodactyl-Pro-/main"

# ==============================
#  DASHBOARD UTAMA
# ==============================
menu() {
clear
neofetch --ascii_distro ubuntu

echo "┏╾─⧼ 𝐏𝐭𝐞𝐫𝐨𝐝𝐚𝐜𝐭𝐲𝐥 𝐏𝐫𝐨 - 𝐃𝐚𝐬𝐡𝐛𝐨𝐚𝐫𝐝 ⧽─╸"
echo "│ 1. Install Protect"
echo "│ 2. Uninstall Protect"
echo "│ 3. Update Script"
echo "│ 4. Exit"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -n "Pilih menu: "
read pilihan

case $pilihan in
    1) install_menu ;;
    2) uninstall_menu ;;
    3) update_script ;;
    4) exit 0 ;;
    *) echo "❌ Pilihan tidak valid!"; sleep 1; menu ;;
esac
}

# ==============================
#  INSTALL MENU
# ==============================
install_menu() {
clear
neofetch --ascii_distro ubuntu

echo "┏╾─⧼ Install Protect Menu ⧽─╸"
echo "│ 1. Anti Delete Server"
echo "│ 2. Anti Delete User"
echo "│ 3. Anti Intip Allocation"
echo "│ 4. Anti Intip Nodes"
echo "│ 5. Anti Intip Nest"
echo "│ 6. Anti Intip Settings"
echo "│ 7. Anti Intip Server #1"
echo "│ 8. Anti Intip Server #2"
echo "│ 9. Anti Modifikasi Detail Server"
echo "│ 10. Install ALL Protect"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -n "Pilih install (1-10): "
read inst

if [[ $inst =~ ^[1-9]$ ]]; then
    sh <(curl -s "$BASE_URL/install/YudzxTech$inst.sh")
elif [[ $inst == "10" ]]; then
    sh <(curl -s "$BASE_URL/install/YudzxTechall.sh")
else
    echo "❌ Menu tidak valid."
fi

echo ""
read -p "Tekan ENTER untuk kembali..."
menu
}

# ==============================
#  UNINSTALL MENU
# ==============================
uninstall_menu() {
clear
neofetch --ascii_distro ubuntu

echo "┏╾─⧼ Uninstall Protect Menu ⧽─╸"
echo "│ 1–9. Uninstall Protect per File"
echo "│ 10. Uninstall ALL Protect"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -n "Pilih uninstall (1-10): "
read unin

if [[ $unin =~ ^[1-9]$ ]]; then
    sh <(curl -s "$BASE_URL/uninstall/uninstallprotect$unin.sh")
elif [[ $unin == "10" ]]; then
    sh <(curl -s "$BASE_URL/uninstall/uninstall-all.sh")
else
    echo "❌ Menu tidak valid."
fi

echo ""
read -p "Tekan ENTER untuk kembali..."
menu
}

# ==============================
#  UPDATE SCRIPT
# ==============================
update_script() {
clear
echo "🔄 Mengupdate dashboard..."

curl -s "$BASE_URL/dashboard.sh" -o dashboard.sh
chmod +x dashboard.sh

echo "✅ Update selesai! Jalankan ulang: ./dashboard.sh"
exit
}

# Jalankan Menu
menu
