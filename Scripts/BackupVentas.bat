@echo off
REM ===============================
REM Script de copia de seguridad de SQL Server
REM ===============================

REM CONFIGURACIÓN
set "backupFolder=C:\Backups\Ventas"
set "server=localhost"          
set "database=Ventas"

REM RUTA completa a sqlcmd.exe (ajusta según tu sistema)
set "sqlcmdPath=C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\sqlcmd.exe"

REM Crear el directorio de backups si no existe
if not exist "%backupFolder%" mkdir "%backupFolder%"

REM Obtener la fecha y hora en formato ISO (yyyy-MM-dd_HH-mm) usando PowerShell
for /f %%i in ('powershell -Command "Get-Date -Format \'yyyy-MM-dd_HH-mm\'"') do set "timestamp=%%i"

REM Nombrar el archivo de respaldo con la fecha y hora
set "backupFile=%backupFolder%\Ventas_%timestamp%.bak"

REM Ejecutar respaldo usando sqlcmd
"%sqlcmdPath%" -S "%server%" -Q "BACKUP DATABASE [%database%] TO DISK=N'%backupFile%' WITH NOFORMAT, NOINIT, NAME='Full Backup of %database%', SKIP, NOREWIND, NOUNLOAD"

REM Confirmación
echo.
echo Respaldo completado: %backupFile%
pause