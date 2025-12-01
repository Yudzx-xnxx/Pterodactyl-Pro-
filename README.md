# 🛡️ YudzxTech Protection Installer

Script otomatis untuk memasang dan menghapus proteksi pada panel **Pterodactyl**. Dibuat agar mudah digunakan, aman, dan mendukung berbagai OS.

---

## 🚀 Fitur Utama

* Install proteksi 1–10 secara individual
* One-click install ALL protections
* Uninstall 1–10 dan uninstall ALL
* Auto download script dari GitHub RAW
* Menu interaktif
* Auto install + auto run **neofetch** saat mulai

---

## 📦 Cara Install Script

Copy dan jalankan satu baris ini:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/Yudzx-xnxx/Pterodactyl-Pro-/main/dashboard.sh)
```

*(Sesuaikan nama file jika berbeda)*

---

# 📘 Cara Menggunakan (Setiap OS)

## 🐧 Linux (Ubuntu / Debian / CentOS / AlmaLinux)

### **1. Update sistem**

```bash
sudo apt update -y && sudo apt upgrade -y
```

### **2. Install curl (jika belum ada)**

```bash
sudo apt install curl -y
```

### **3. Jalankan script**

```bash
bash <(curl -sSL https://raw.githubusercontent.com/Yudzx-xnxx/Pterodactyl-Pro-/main/dashboard.sh)
```

### **4. Ikuti menu**

* **Install Protect** → pilih proteksi 1–10
* **Uninstall Protect** → pilih hapus proteksi
* **Exit** untuk keluar

---

## 🖥️ macOS

### **1. Install Homebrew (jika belum ada)**

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### **2. Install curl & neofetch**

```bash
brew install curl neofetch
```

### **3. Jalankan script**

```bash
bash <(curl -sSL https://raw.githubusercontent.com/Yudzx-xnxx/Pterodactyl-Pro-/main/dashboard.sh)
```

---

## 🏴‍☠️ Termux (Android)

### **1. Update paket**

```bash
pkg update -y && pkg upgrade -y
```

### **2. Install curl & neofetch**

```bash
pkg install curl neofetch -y
```

### **3. Jalankan script**

```bash
bash <(curl -sSL https://raw.githubusercontent.com/Yudzx-xnxx/Pterodactyl-Pro-/main/dashboard.sh)
```

> ⚠️ Catatan: Termux tidak dapat digunakan untuk server panel Pterodactyl, namun bisa digunakan untuk testing.

---

## 🪟 Windows (WSL Recommended)

### **1. Install WSL**

```powershell
wsl --install
```

Restart komputer.

### **2. Masuk Ubuntu**

Open: **Start → Ubuntu**

### **3. Install curl & neofetch**

```bash
sudo apt install curl neofetch -y
```

### **4. Jalankan script**

```bash
bash <(curl -sSL https://raw.githubusercontent.com/Yudzx-xnxx/Pterodactyl-Pro-/main/dashboard.sh)
```

---

# 📂 Struktur Folder dalam Repo

```
/project
 ├── install/
 │    ├── installprotect1.sh
 │    ├── installprotect2.sh
 │    └── ... sampai 15
 │
 ├── uninstall/
 │    ├── uninstallprotect1.sh
 │    ├── uninstallprotect2.sh
 │    ├── uninstall-all.sh
 │    ├── uninstall-backup.sh
 │    └── uninstall-protect.sh
 │
 └── dashboard.sh
```

---

# 🧩 Menu di Script

### **Menu Utama:**

```
1. Install Protect
2. Uninstall Protect
3. Exit
```

### **Menu Install Protect:**

```
1. Anti Delete Server
2. Anti Delete User
3. Anti Intip Allocation
4. Anti Intip Nodes
5. Anti Intip Nest
6. Anti Intip Settings
7. Anti Akses Server (1)
8. Anti Akses Server (2)
9. Anti Modifikasi Detail Server
10. Install ALL
```

### **Menu Uninstall Protect:**

```
1–9   Uninstall per proteksi
10    Uninstall ALL
```

---

# ☕ Dukungan

Jika terbantu, boleh support melalui:

* Telegram: **t.me/Yudzxcysec**
* GitHub Issues untuk bug-report

---

# 💬 Lisensi

Script ini bebas dipakai, modifikasi, dan disebarkan.

---

**Made with ❤️ by YudzxTech**
