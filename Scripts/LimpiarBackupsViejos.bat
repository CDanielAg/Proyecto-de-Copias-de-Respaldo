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

REM Contar archivos antiguos usando PowerShell
powershell -Command "try { $files = Get-ChildItem '%backupFolder%' -Filter '*.bak' | Where-Object { $_.LastWriteTime -le (Get-Date).AddDays(-15) }; if ($files.Count -eq 0) { Write-Host 'No se encontraron archivos antiguos para eliminar.' } else { Write-Host 'Archivos antiguos encontrados: ' $files.Count; foreach ($file in $files) { Remove-Item $file.FullName -Force; Write-Host 'Archivo eliminado: ' $file.Name } } } catch { Write-Host 'Error en el proceso:' $_.Exception.Message }"

REM Mostrar resumen
echo.
echo ===============================
echo Resumen del proceso de limpieza
echo ===============================
echo Fecha y hora: %currentDateTime%
echo Carpeta de backups: %backupFolder%
echo Estado: Completado
echo ===============================

pause