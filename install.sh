#!/bin/bash

echo "📥 Installing Dashboard..."
curl -sSL https://raw.githubusercontent.com/Yudzx-xnxx/Pterodactyl-Pro-/main/dashboard.sh -o /usr/local/bin/ptero-pro
chmod +x /usr/local/bin/ptero-pro

echo "✅ Instalasi selesai!"
echo "Jalankan dengan perintah: ptero-pro"
