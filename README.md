# Instalador y Configurador de x11vnc para Arch Linux

Este proyecto contiene un script que **instala, configura y habilita** `x11vnc` como servicio en Arch Linux, protegiéndolo con contraseña y arrancándolo automáticamente al inicio del sistema.

## 📋 Requisitos

- Arch Linux o derivado (Manjaro, EndeavourOS, etc.)
- Usuario con permisos `sudo`
- Servidor X en ejecución (entorno gráfico)

## 🚀 Instalación y uso

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/glmbxecurity/x11vnc-server-auto
   cd x11vnc-server-auto
   ```

2. Dar permisos al script:
   ```bash
   chmod +x setup.sh
   ```

3. Ejecutar el script:
   ```bash
   ./setup.sh
   ```
   El script pedirá:
   - **Usuario** al que se asociará el servicio.
   - **Contraseña** para el acceso VNC.

## 🔧 Qué hace el script

- Instala `x11vnc` desde los repositorios oficiales.
- Genera un archivo de contraseña en `~/.vnc/passwd`.
- Crea un servicio `systemd` para iniciar `x11vnc` automáticamente.
- Configura el servicio para usar la contraseña establecida.
- Habilita y arranca el servicio.

## 📡 Conexión al servidor

Por defecto, el servicio escucha en el puerto **5900**.  
Puedes conectarte con cualquier cliente VNC usando:

```
IP_DEL_SERVIDOR:5900
```

## 📜 Licencia

Este proyecto se distribuye bajo la licencia **MIT**.
