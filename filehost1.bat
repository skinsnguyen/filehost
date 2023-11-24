@echo off

REM Cấp quyền đọc và ghi cho tất cả người dùng đối với tệp hosts
icacls "C:\Windows\System32\drivers\etc\hosts" /grant Everyone:(RX,W)

REM Khởi tạo biến
set hostsPath="C:\Windows\System32\drivers\etc\hosts"
set tempFile="$env:TEMP\hosts.tmp"

REM Vòng lặp menu
:menu
cls
echo -------------- Menu --------------
echo 1. Hiển Thị Tất Cả Địa Chỉ IP
echo 2. Thay Thế Địa Chỉ IP
echo 3. Thoát
echo ----------------------------------

set /p "choice=Chọn một tùy chọn (1-3): "

REM Tiến hành xử lý dựa trên tùy chọn người dùng
if "%choice%"=="1" (
    REM Hiển thị danh sách các địa chỉ IP
    echo Danh sách các địa chỉ IP trong tệp hosts:
    findstr /R /C:"^[[:space:]]*[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*[[:space:]]*" "%hostsPath%"
    pause
    goto menu
) else if "%choice%"=="2" (
    REM Thay thế một địa chỉ IP bằng một địa chỉ IP khác
    echo Nhập địa chỉ IP cũ:
    set oldIP
    echo Nhập địa chỉ IP mới:
    set newIP

    REM Tìm tất cả các dòng trong tệp hosts chứa địa chỉ IP cũ
    findstr /v /C:"%oldIP%" "%hostsPath%" > "%tempFile%"

    REM Thêm địa chỉ IP mới vào cuối mỗi dòng được tìm thấy
    echo %newIP% >> "%tempFile%"

    REM Ghi các thay đổi vào tệp hosts
    move /y "%tempFile%" "%hostsPath%"
    ipconfig /flushdns
    echo Đã thay đổi địa chỉ IP thành công.
    pause
    goto menu
) else if "%choice%"=="3" (
    REM Thoát khỏi chương trình
    exit
) else (
    REM Thông báo lỗi
    echo Lựa chọn không hợp lệ. Vui lòng nhập lại.
    pause
    goto menu
)
