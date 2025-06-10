#!/bin/bash

# Warna untuk output
green="\e[32m"
red="\e[31m"
reset="\e[0m"

echo -e "${green}== WARP-CLI Installer & Manager for Debian ==${reset}"

function install_warp() {
    echo -e "${green}Mulai instalasi WARP-CLI...${reset}"
    sudo apt update && sudo apt upgrade -y
    wget https://pkg.cloudflareclient.com/packages/cloudflare-warp-release-latest.deb
    sudo dpkg -i cloudflare-warp-release-latest.deb
    sudo apt update
    sudo apt install cloudflare-warp -y
    echo -e "${green}Instalasi selesai.${reset}"
}

function enable_service() {
    echo -e "${green}Mengaktifkan dan menjalankan layanan warp-svc...${reset}"
    sudo systemctl enable warp-svc
    sudo systemctl start warp-svc
}

function toggle_always_on() {
    echo "1. Enable Always-On"
    echo "2. Disable Always-On"
    read -p "Pilih opsi (1/2): " choice
    case $choice in
        1) warp-cli enable-always-on ;;
        2) warp-cli disable-always-on ;;
        *) echo -e "${red}Pilihan tidak valid.${reset}" ;;
    esac
}

function register_warp() {
    echo -e "${green}Registrasi WARP-CLI...${reset}"
    warp-cli register
}

function connect_warp() {
    echo -e "${green}Menyambungkan ke WARP...${reset}"
    warp-cli connect
}

function check_status() {
    warp-cli status
}

function disconnect_warp() {
    warp-cli disconnect
}

while true; do
    echo -e "\n${green}=== MENU WARP-CLI ===${reset}"
    echo "1. Instalasi WARP-CLI"
    echo "2. Aktifkan Service warp-svc"
    echo "3. Enable/Disable Always-On"
    echo "4. Registrasi WARP"
    echo "5. Koneksi WARP"
    echo "6. Cek Status"
    echo "7. Stop WARP"
    echo "0. Keluar"
    read -p "Pilih opsi (0-7): " menu

    case $menu in
        1) install_warp ;;
        2) enable_service ;;
        3) toggle_always_on ;;
        4) register_warp ;;
        5) connect_warp ;;
        6) check_status ;;
        7) disconnect_warp ;;
        0) echo -e "${green}Keluar...${reset}"; exit 0 ;;
        *) echo -e "${red}Pilihan tidak valid.${reset}" ;;
    esac
done
