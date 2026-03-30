@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\Keega\Downloads\STM32L051\Period\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\Keega\Downloads\STM32L051\Period\main.c"
if not exist hex2mif.exe goto done
if exist main.ihx hex2mif main.ihx
if exist main.hex hex2mif main.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\Keega\Downloads\STM32L051\Period\main.hex
