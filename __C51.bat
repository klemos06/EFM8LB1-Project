@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\Keega\Downloads\EFM8LB1-Project\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c"
if not exist hex2mif.exe goto done
if exist Base Joystick + Signal.ihx hex2mif Base Joystick + Signal.ihx
if exist Base Joystick + Signal.hex hex2mif Base Joystick + Signal.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.hex
