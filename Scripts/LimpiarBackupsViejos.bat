@echo off
REM Script para eliminar backups mayores a 15 días
set "backupFolder=C:\Backups\Ventas"

REM Verificar si la carpeta de backups existe
if not exist "%backupFolder%" (
    echo Error: La carpeta de backups no existe: %backupFolder%
    echo Por favor, verifique la ruta y vuelva a intentarlo.
    pause
    exit /b 1
)

REM Obtener la fecha y hora actual
for /f "usebackq" %%i in (`powershell -Command "Get-Date -Format 'yyyy-MM-dd_HH:mm:ss'"`) do set "currentDateTime=%%i"

echo Iniciando proceso de limpieza de backups...
echo Carpeta de backups: %backupFolder%
echo Fecha y hora actual: %currentDateTime%
echo.

REM Contar archivos antiguos
set "filesFound=0"
forfiles /p "%backupFolder%" /m *.bak /d -15 /c "cmd /c set /a filesFound+=1"
echo Archivos antiguos encontrados: %filesFound%

REM Eliminar archivos antiguos
echo Eliminando archivos antiguos...
forfiles /p "%backupFolder%" /m *.bak /d -15 /c "cmd /c del /q @path"

REM Verificar si se eliminaron archivos
set "filesDeleted=0"
forfiles /p "%backupFolder%" /m *.bak /d -15 /c "cmd /c set /a filesDeleted+=1"
echo Archivos eliminados: %filesDeleted%

REM Mostrar resumen
echo.
echo ===============================
echo Resumen del proceso de limpieza
echo ===============================
echo Fecha y hora: %currentDateTime%
echo Carpeta de backups: %backupFolder%
echo Archivos antiguos encontrados: %filesFound%
echo Archivos eliminados: %filesDeleted%
echo Estado: Completado
echo ===============================

pause