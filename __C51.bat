@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\ELEC 291\EFM8LB1-Project\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c"
if not exist hex2mif.exe goto done
if exist WIP_IRCOMMS.ihx hex2mif WIP_IRCOMMS.ihx
if exist WIP_IRCOMMS.hex hex2mif WIP_IRCOMMS.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.hex
