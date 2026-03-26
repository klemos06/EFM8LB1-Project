@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\ELEC 291\EFM8LB1-Project\Period\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\ELEC 291\EFM8LB1-Project\Period\main.c"
if not exist hex2mif.exe goto done
if exist main.ihx hex2mif main.ihx
if exist main.hex hex2mif main.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\ELEC 291\EFM8LB1-Project\Period\main.hex
