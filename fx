Nguyên nhân biểu tượng SplitCam vẫn còn trên Taskbar là do tiến trình SplitCam.exe cũ (đang chạy dưới tài khoản User hiện tại) chưa được tắt trước khi chạy tác vụ SYSTEM, hoặc file SplitCam.exe tự gọi thêm một tiến trình con giao diện (SplitCamUI / khay hệ thống) vào phiên đăng nhập hiện tại.

Thực hiện 3 bước sau để đóng tiến trình cũ và ép SplitCam chạy ẩn hoàn toàn không hiện trên Taskbar hay khay hệ thống:

Dừng toàn bộ tiến trình SplitCam đang chạy:
Mở PowerShell (Admin) bên trong máy ảo và chạy lệnh sau để tắt sạch các tiến trình SplitCam cũ:

PowerShell
Stop-Process -Name "*SplitCam*" -Force -ErrorAction SilentlyContinue
Kiểm tra: Biểu tượng SplitCam trên thanh Taskbar và trong mũi tên ^ của khay hệ thống biến mất hoàn toàn.

Chép file cấu hình sang thư mục của tài khoản SYSTEM:
Vì tài khoản SYSTEM dùng thư mục cấu hình riêng chứ không đọc file default.scproject trong C:\Users\<tên_user>\AppData\Local\SplitCam, hãy chạy lệnh sau trong PowerShell (Admin) để đồng bộ cấu hình nguồn NDI sang cho SYSTEM:

PowerShell
$sysDir = "C:\Windows\System32\config\systemprofile\AppData\Local\SplitCam"
New-Item -ItemType Directory -Path $sysDir -Force | Out-Null
Copy-Item -Path "$env:LOCALAPPDATA\SplitCam\*" -Destination $sysDir -Recurse -Force
Kiểm tra: PowerShell chạy xong không báo lỗi đỏ.

Kích hoạt lại tác vụ chạy ngầm SplitCamHidden:
Chạy tiếp lệnh sau trong PowerShell (Admin):

PowerShell
Start-ScheduledTask -TaskName "SplitCamHidden"
Kiểm tra: Mở Task Manager (Ctrl + Shift + Esc) > thẻ Details, thấy SplitCam.exe chạy dưới tên người dùng SYSTEM; thanh Taskbar và khay hệ thống hoàn toàn không có biểu tượng SplitCam nhưng Zoom vẫn nhận được hình ảnh camera.
