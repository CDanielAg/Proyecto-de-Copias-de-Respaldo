@echo off
set "backupFolder=C:\Backups\Ventas"

REM Verificar si la carpeta de backups existe
if not exist "%backupFolder%" (
    echo Error: La carpeta de backups no existe: %backupFolder%
    echo Por favor, verifique la ruta y vuelva a intentarlo.
    pause
    exit /b 1
)

REM Verificar si hay archivos .bak en la carpeta
set "filesFound=0"
for %%f in ("%backupFolder%\*.bak") do (
    set "filesFound=1"
    goto :checkFiles
)
:checkFiles
if "%filesFound%"=="0" (
    echo No se encontraron archivos .bak en la carpeta: %backupFolder%
    echo El script no realizará ninguna compresión.
    pause
    exit /b 1
)

REM Mostrar mensaje de inicio
echo Iniciando proceso de compresión...
echo Buscando archivos .bak en: %backupFolder%
echo.

REM Ejecutar PowerShell con manejo de errores y resumen en una línea
powershell -Command "try { $files = Get-ChildItem '%backupFolder%' -Filter '*.bak'; if ($files.Count -eq 0) { Write-Host 'No se encontraron archivos .bak'; exit 1 }; $totalFiles = $files.Count; $compressedFiles = 0; $errors = 0; $skippedFiles = 0; foreach ($file in $files) { $zipPath = $file.FullName + '.zip'; if (Test-Path $zipPath) { Write-Host 'Archivo ya comprimido:' $file.Name -ForegroundColor Yellow; $skippedFiles++; continue }; Write-Host 'Comprimiendo archivo:' $file.Name; try { Compress-Archive -Path $file.FullName -DestinationPath $zipPath -Force -ErrorAction Stop; Write-Host 'Comprimido exitosamente:' $file.Name -ForegroundColor Green; $compressedFiles++ } catch { Write-Host 'Error al comprimir:' $file.Name -ForegroundColor Red; Write-Host $_.Exception.Message -ForegroundColor Red; $errors++ } }; Write-Host "`nResumen del proceso:" -ForegroundColor Yellow; Write-Host "Archivos encontrados: $totalFiles" -ForegroundColor Yellow; Write-Host "Archivos comprimidos: $compressedFiles" -ForegroundColor Yellow; Write-Host "Archivos ya comprimidos: $skippedFiles" -ForegroundColor Yellow; Write-Host "Errores encontrados: $errors" -ForegroundColor Yellow; if ($errors -gt 0) { exit 1 } } catch { Write-Host 'Error en el proceso:' $_.Exception.Message -ForegroundColor Red; exit 1 }"

REM Mostrar mensaje final
if %errorlevel%==0 (
    echo.
    echo Proceso de compresión completado exitosamente.
    echo Se comprimieron todos los archivos .bak encontrados.
) else (
    echo.
    echo El proceso de compresión terminó con errores.
    echo Verifique los mensajes de error anteriores.
)

pause