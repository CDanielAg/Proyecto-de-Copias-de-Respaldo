# 🗄️ Sistema de Gestión de Ventas

## Descripción
Sistema integral de gestión de ventas con base de datos SQL Server, que incluye un robusto sistema de copias de seguridad automatizadas y auditoría detallada de operaciones.

## 🏗️ Estructura del Proyecto

```
Proyecto-de-Copias-de-Respaldo/
├── BD/
│   ├── Ventas.sql           # Script principal de la base de datos
│   └── triggers.sql         # Triggers para el sistema de auditoría
├── Auditorias/
│   └── auditoria.sql       # Configuración de tablas de auditoría
├── Scripts/
│   ├── BackupVentas.bat     # Script para realizar copias de seguridad
│   └── LimpiarBackupsViejos.bat  # Limpieza automática de backups antiguos
└── README.md                # Documentación del proyecto
```

## 🚀 Características Principales

### 🔄 Sistema de Copias de Seguridad
- **Automatización**: Copias programadas 3 veces por semana (lunes, miércoles y viernes a media noche)
- **Optimización**: Comprimido en formato .zip para ahorrar espacio
- **Mantenimiento**: Limpieza automática de backups con más de 15 días
- **Registro**: Log detallado de cada operación de respaldo
- **Portabilidad**: Compatible con cualquier configuración regional de Windows

### 🔍 Sistema de Auditoría
- **Monitoreo completo**: Registra todas las operaciones (INSERT, UPDATE, DELETE)
- **Trazabilidad**: Almacena tanto los datos antiguos como los nuevos
- **Seguridad**: Registra usuario, host y timestamp de cada operación
- **Tablas auditadas**:
  - Clientes
  - Productos
  - Ventas
  - Detalles de venta
  - Proveedores

### 🛠️ Scripts de Mantenimiento
- `BackupVentas.bat`: Realiza copias de seguridad completas
- `LimpiarBackupsViejos.bat`: Elimina automáticamente backups antiguos
- Configuración de tareas programadas para ejecución automática

## 📋 Requisitos del Sistema

- **Base de Datos**: SQL Server 2016 o superior
- **Sistema Operativo**: Windows 10/11 o Windows Server 2016+
- **PowerShell**: Versión 5.1 o superior
- **Permisos**:
  - Credenciales de administrador para configurar tareas programadas
  - Permisos de lectura/escritura en las carpetas de destino
- **Espacio en Disco**: Mínimo 1GB recomendado para almacenamiento de backups

## 🛠️ Instalación y Configuración

### 1. Configuración Inicial de la Base de Datos
```sql
-- Conectarse a SQL Server y ejecutar:
sqlcmd -S localhost -i "BD\Ventas.sql"
```

### 2. Configurar el Sistema de Auditoría
```sql
-- Ejecutar en orden:
sqlcmd -S localhost -i "Auditorias\auditoria.sql"
sqlcmd -S localhost -i "BD\triggers.sql"
```

### 3. Configurar Tareas Programadas

#### Opción A: Configuración Manual
1. Abrir el Programador de tareas de Windows
2. Crear una tarea básica que ejecute `Scripts\BackupVentas.bat`
3. Programar para ejecutarse Lunes, Miércoles y Viernes a las 00:00

#### Opción B: Usar PowerShell (ejecutar como administrador)
```powershell
# Crear tarea programada para backups
$action = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c `"cd /d %~dp0 && .\Scripts\BackupVentas.bat`"" -WorkingDirectory "$(Get-Location)"
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday, Wednesday, Friday -At 12am
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Backup Ventas BD" -Description "Copia de seguridad automática de la base de datos Ventas"
```

## 📂 Estructura de Archivos

```
%USERPROFILE%\Documents\
└── Backups\
    ├── Ventas\              # Copias de seguridad (.bak y .zip)
    │   ├── Ventas_20240520.bak
    │   └── Ventas_20240520.zip
    └── Logs\                # Archivos de registro
        ├── Backup_20240520.log
        └── Auditoria_20240520.log
```

## 🔄 Mantenimiento

### Tareas Automáticas
- **Backup**: Ejecución automática 3 veces por semana
- **Limpieza**: Eliminación de backups con más de 15 días
- **Registro**: Generación de logs detallados

### Monitoreo
- Verificar regularmente la carpeta de logs
- Monitorear el espacio en disco
- Revisar los logs de Windows para errores en las tareas programadas

## ⚠️ Notas Importantes

- **Espacio en Disco**: Mantener al menos 10% de espacio libre en la unidad
- **Seguridad**: 
  - Mantener las credenciales de la base de datos seguras
  - Limitar el acceso a las carpetas de backup
- **Rendimiento**: 
  - Los backups se realizan durante la noche para minimizar impacto
  - La compresión reduce el espacio en disco pero requiere más CPU

## 📝 Soporte

Para reportar problemas o solicitar asistencia, por favor:
1. Revisar los archivos de log correspondientes
2. Documentar los pasos para reproducir el problema
3. Incluir capturas de pantalla si es necesario

---

📅 **Última actualización**: Mayo 2024  
💻 **Versión**: 2.0.0