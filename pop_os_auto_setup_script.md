#!/bin/bash

# Thiết lập màu sắc cho thông báo dễ nhìn
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}==============================================================${NC}"
echo -e "${GREEN}   BẮT ĐẦU THIẾT LẬP POP!_OS TỐI ƯU CHO AMD & KVM MÁY ẢO    ${NC}"
echo -e "${GREEN}==============================================================${NC}"
sleep 2

# 1. Tự động chấp nhận EULA cho bộ cài đặt font và Codec (tránh bị dừng khi đang chạy auto)
echo -e "\n${YELLOW}[1/7] Cấu hình tự động chấp nhận bản quyền thư viện Media...${NC}"
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

# 2. Cập nhật hệ thống
echo -e "\n${YELLOW}[2/7] Đang cập nhật hệ thống Pop!_OS (Update & Upgrade)...${NC}"
sudo apt update && sudo apt upgrade -y

# 3. Cài đặt môi trường ảo hóa KVM/QEMU, Virt-Manager và OVMF (UEFI cho máy ảo)
echo -e "\n${YELLOW}[3/7] Đang cài đặt KVM/QEMU và hệ thống quản lý Virt-Manager...${NC}"
sudo apt install -y qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager ebtables dnsmasq ovmf

# 4. Cấp quyền truy cập máy ảo cho User hiện tại (tránh lỗi permission denied)
echo -e "\n${YELLOW}[4/7] Đang cấp quyền KVM/USB Passthrough cho tài khoản: $USER...${NC}"
sudo adduser $USER libvirt
sudo adduser $USER libvirt-qemu
sudo adduser $USER kvm

# Kích hoạt dịch vụ ảo hóa chạy ngầm
sudo systemctl enable --now libvirtd

# 5. Cài đặt các phần mềm giải trí, tiện ích và dọn dẹp
echo -e "\n${YELLOW}[5/7] Đang cài đặt Stacer, OBS Studio, Gnome Tweaks và Codec giải trí...${NC}"
sudo apt install -y ubuntu-restricted-extras stacer gnome-tweaks obs-studio htop curl git radeontop

# 6. Dọn dẹp rác hệ thống sau khi cài
echo -e "\n${YELLOW}[6/7] Đang dọn dẹp file rác và tối ưu dung lượng ổ cứng...${NC}"
sudo apt autoremove --purge -y
sudo apt clean

echo -e "\n${GREEN}==============================================================${NC}"
echo -e "${GREEN}      THIẾT LẬP HOÀN TẤT! HỆ THỐNG ĐÃ SẴN SÀNG SỬ DỤNG      ${NC}"
echo -e "${GREEN}==============================================================${NC}"
echo -e "Để các quyền KVM và Camera có hiệu lực hoàn toàn, bạn cần khởi động lại máy."
echo -e "Hãy gõ lệnh: ${YELLOW}sudo reboot${NC} để khởi động lại ngay bây giờ."