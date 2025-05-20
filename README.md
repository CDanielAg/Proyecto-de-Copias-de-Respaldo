# Proyecto-de-Copias-de-Respaldo

## Sistema de Copias de Seguridad y Auditoría

## Descripción
Este proyecto implementa un sistema completo de copias de seguridad y auditoría para la base de datos Ventas.

## Estructura del Proyecto

```
Proyecto-de-Copias-de-Respaldo/
├── BD/
│   ├── Ventas.sql          # Script de creación de la base de datos
│   └── triggers.sql         # Triggers para auditoría
├── Scripts/
│   ├── BackupVentas.bat     # Script de copia de seguridad
│   └── ScheduleBackup.ps1   # Script para programar el backup
└── README.md               # Documentación
```

## Funcionalidades

### Copias de Seguridad
- Copias de seguridad automáticas 3 veces por semana (lunes, miércoles y viernes a media noche)
- Comprimido en formato .zip para reducir el espacio
- Limpieza automática de backups antiguos (más de 15 días)
- Registro detallado de cada operación
- Manejo de formatos de fecha y hora independiente del sistema regional

### Auditoría
- Sistema de auditoría completo para todas las tablas
- Registro de todas las operaciones (INSERT, UPDATE, DELETE)
- Almacenamiento de datos anteriores y nuevos
- Registro del usuario y host que realizó la operación
- Fecha y hora de cada operación

## Requisitos

- SQL Server
- PowerShell
- Permisos de administrador para programar tareas
- Espacio en disco para almacenar los backups

## Instalación

1. Ejecutar el script de base de datos:
   ```sql
   sqlcmd -S localhost -i BD/Ventas.sql
   ```

2. Ejecutar el script de triggers:
   ```sql
   sqlcmd -S localhost -i BD/triggers.sql
   ```

3. Programar el backup:
   ```powershell
   # Ejecutar con privilegios de administrador
   .\Scripts\ScheduleBackup.ps1
   ```

## Mantenimiento

- Los backups se almacenan en: `%USERPROFILE%\Documents\Backups\Ventas`
- Los logs se almacenan en: `%USERPROFILE%\Documents\Backups\Logs`
- Los backups antiguos (más de 15 días) se eliminan automáticamente
- Los archivos bak se comprimen en .zip para ahorrar espacio

## Notas

- Asegúrese de tener suficiente espacio en disco para los backups
- Verifique los permisos de la carpeta de backups
- Los logs contienen información detallada de cada operación de backup
- El sistema es independiente del formato regional de Windows