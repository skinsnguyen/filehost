@echo off
icacls "C:\Windows\System32\drivers\etc\hosts" /grant Everyone:(RX,W)
:menu
cls
echo -------------- Menu --------------
echo 1. Hiển Thị Tất Cả Địa Chỉ IP
echo 2. Thay Thế Địa Chỉ IP
echo 3. Thoát
echo ----------------------------------

set /p "choice=Chọn một tùy chọn (1-3): "

if "%choice%"=="1" goto displayAllIP
if "%choice%"=="2" goto replaceIP
if "%choice%"=="3" goto :eof

:displayAllIP
echo Danh sách các địa chỉ IP trong tệp hosts:
set "hostsPath=C:\Windows\System32\drivers\etc\hosts"
findstr /R /C:"^[[:space:]]*[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*[[:space:]]*" "%hostsPath%"
pause
goto menu

:replaceIP
set "hostsPath=C:\Windows\System32\drivers\etc\hosts"
set /p "oldIP=Nhập địa chỉ IP cũ: "
set /p "newIP=Nhập địa chỉ IP mới: "
findstr /v /C:"%oldIP%" "%hostsPath%" > "%tempFile%"
echo %newIP% >> "%tempFile%"
move /y "%tempFile%" "%hostsPath%"
ipconfig /flushdns
echo Đã thay đổi địa chỉ IP thành công.
pause
goto menu
