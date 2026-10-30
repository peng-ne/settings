# Fedora Workstation Post-Installation & Optimization Guide

Hướng dẫn tối ưu toàn diện Fedora Workstation cho cấu hình **AMD Ryzen 7 7800X3D + RX 9060 XT**, màn hình **210Hz**, ảo hóa **KVM/Virt-Manager** và trình duyệt **Brave**.

---

## BƯỚC 0: Tối Ưu Tốc Độ DNF & Mirror Tốc Độ Cao (CẦN LÀM ĐẦU TIÊN)

Cấu hình DNF để tự động chọn mirror nhanh nhất và tăng số luồng tải xuống song song.

```bash
# Thêm cấu hình max_parallel_downloads và fastestmirror vào dnf.conf
echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf
echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf
echo "defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf
```

---

## BƯỚC 1: Cập Nhật Hệ Thống & Bật Kho RPM Fusion

```bash
# Bật kho phần mềm RPM Fusion (Free & Non-Free)
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Bật Flathub Store
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Cập nhật toàn bộ hệ thống
sudo dnf update -y
```

---

## BƯỚC 2: Cài Đặt Trình Duyệt Brave

```bash
# Thêm repository chính thức của Brave
sudo dnf install dnf-plugins-core -y
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# Cài đặt Brave Browser
sudo dnf install brave-browser -y
```

---

## BƯỚC 3: Tối Ưu Đồ Họa AMD Radeon RX & Multimedia Codecs

```bash
# Cài đặt Driver Mesa VA-API & VDPAU cho tăng tốc phần cứng GPU AMD
sudo dnf install mesa-va-drivers mesa-vdpau-drivers -y

# Cài đặt đầy đủ Multimedia Codecs
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install ffmpeg gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly -y
```

---

## BƯỚC 4: Cài Đặt Môi Trường Ảo Hóa KVM / QEMU / Virt-Manager

```bash
# Cài đặt bộ công cụ KVM/QEMU chuẩn Red Hat
sudo dnf install qemu-kvm libvirt virt-manager bridge-utils virt-viewer edk2-ovmf -y

# Kích hoạt dịch vụ libvirtd và thêm User vào group quản trị
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $USER
```

---

## BƯỚC 5: Cài Đặt Bộ Gõ Tiếng Việt IBus-Bamboo

```bash
# Cài đặt ibus-bamboo trực tiếp từ kho Fedora
sudo dnf install ibus-bamboo -y

# Khởi động lại IBus
ibus restart
```

*Sau khi khởi động lại máy, truy cập:* **Settings > Keyboard > Input Sources > Add (+)** $\rightarrow$ chọn **Vietnamese** $\rightarrow$ chọn **Vietnamese (Bamboo)**.

---

## BƯỚC 6: Tối Ưu Hiển Thị 210Hz & VRR (FreeSync) บน Wayland

1. Truy cập **Settings > Displays**.
2. Chọn **Refresh Rate**: `210Hz`.
3. Bật **Variable Refresh Rate (VRR / FreeSync)** nếu màn hình hỗ trợ để có trải nghiệm mượt nhất.

---

## BƯỚC 7: Cài Đặt Các Ứng Dụng Bổ Sung (Tùy Chọn)

```bash
# Cài đặt HTop / BTOP theo dõi tài nguyên hệ thống
sudo dnf install btop htop Fastfetch -y

# Cài đặt OBS Studio (Quay/Stream màn hình mượt trên Wayland)
sudo dnf install obs-studio -y
```

---

## BƯỚC 8: Khởi Động Lại Hệ Thống

Chạy lệnh sau để áp dụng toàn bộ cấu hình, kernel updates và phân quyền user:

```bash
sudo reboot
```