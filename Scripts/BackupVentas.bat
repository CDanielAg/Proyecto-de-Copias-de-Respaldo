@echo off
REM ===============================
REM Script de copia de seguridad de SQL Server
REM ===============================

REM CONFIGURACIÓN
set "backupFolder=C:\Backups\Ventas"
set "server=DESKTOP-6A5UV7A\SQLEXPRESS"
set "database=Ventas"

REM RUTA completa a sqlcmd.exe (ajusta según tu sistema)
set "sqlcmdPath=%ProgramFiles%\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\sqlcmd.exe"

REM Verificar si la carpeta de backups existe
if not exist "%backupFolder%" (
    echo Creando carpeta de backups...
    mkdir "%backupFolder%"
    if errorlevel 1 (
        echo Error: No se pudo crear la carpeta de backups
        pause
        exit /b 1
    )
)

REM Obtener la fecha y hora en formato ISO (yyyy-MM-dd_HH-mm)
for /f "usebackq" %%i in (`powershell -Command "Get-Date -Format 'yyyy-MM-dd_HH-mm'"`) do set "timestamp=%%i"

REM Verificar si se obtiene correctamente
echo Fecha y hora: %timestamp%
pause

REM Nombrar el archivo de respaldo
set "backupFile=%backupFolder%\Ventas_%timestamp%.bak"
echo Archivo destino: %backupFile%
pause

REM Ejecutar respaldo
echo Iniciando proceso de backup...
echo Servidor: %server%
echo Base de datos: %database%
echo Archivo de destino: %backupFile%
echo.

REM Ejecutar el comando de backup
"%sqlcmdPath%" -S "%server%" -Q "BACKUP DATABASE [%database%] TO DISK=N'%backupFile%' WITH NOFORMAT, NOINIT, NAME='Full Backup of %database%', SKIP, NOREWIND, NOUNLOAD"

REM Verificar si el backup fue exitoso
if errorlevel 1 (
    echo Error: El backup falló
    pause
    exit /b 1
) else (
    echo Backup completado exitosamente
    echo.
    
    REM Mostrar resumen del proceso
    echo ===============================
    echo Resumen del proceso de backup
    echo ===============================
    echo Fecha y hora: %timestamp%
    echo Servidor: %server%
    echo Base de datos: %database%
    echo Archivo generado: %backupFile%
    echo Estado: Completado exitosamente
    echo ===============================
)

pause