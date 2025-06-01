#!/bin/bash

# ========================================
# 🌐 Cloudflare WARP CLI Installer & Setup
# 🐧 Debian 12 (Bookworm)
# 🛠️ Mode: Otomatis & Manual
# ========================================

clear
echo "======================================="
echo "🌐 Cloudflare WARP Setup untuk Debian 12"
echo "📦 Author: ChatGPT | 2025"
echo "======================================="
echo ""
echo "Pilih mode konfigurasi:"
echo "1) Mode Otomatis (WARP aktif saat boot)"
echo "2) Mode Manual (WARP dijalankan manual)"
echo ""

read -p "Masukkan pilihan Anda (1/2): " pilihan

# Install dependencies
echo ""
echo "📥 Menginstall dependensi..."
sudo apt update
sudo apt install curl gnupg lsb-release -y

# Tambah repo Cloudflare
echo "📦 Menambahkan repository Cloudflare..."
curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/cloudflare-warp.gpg

echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp.gpg] https://pkg.cloudflareclient.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list

# Install paket warp
sudo apt update
sudo apt install cloudflare-warp -y

# Start warp-svc
echo "▶️ Memulai layanan warp-svc..."
sudo systemctl start warp-svc
sleep 2

# Register perangkat
echo "📝 Registrasi perangkat ke jaringan WARP..."
sudo warp-cli registration new

# Mode pilihan
if [ "$pilihan" = "1" ]; then
    echo "✅ Mode Otomatis dipilih..."
    sudo warp-cli connect
    sudo systemctl enable warp-svc
    echo ""
    echo "✅ WARP sekarang akan aktif otomatis saat boot."
elif [ "$pilihan" = "2" ]; then
    echo "🔧 Mode Manual dipilih..."
    echo ""
    echo "Silakan jalankan manual saat dibutuhkan:"
    echo "  ▶️ sudo systemctl start warp-svc"
    echo "  🔗 sudo warp-cli connect"
    echo "  ❌ sudo warp-cli disconnect"
    echo "  ⏹️ sudo systemctl stop warp-svc"
else
    echo "❌ Pilihan tidak valid. Harap jalankan ulang skrip."
    exit 1
fi

# Tes koneksi
echo ""
echo "🌍 Tes IP publik Anda..."
curl ifconfig.me

echo ""
echo "✅ Instalasi selesai. Gunakan 'warp-cli status' untuk melihat status."
