#!/bin/bash

# Script para instalar y configurar x11vnc en Arch Linux como servicio con contraseña

echo "=== Configuración automática de x11vnc en Arch Linux ==="
read -p "Introduce tu nombre de usuario: " USUARIO
HOME_DIR=$(eval echo "~$USUARIO")

if [ ! -d "$HOME_DIR" ]; then
    echo "❌ El usuario $USUARIO no existe en el sistema."
    exit 1
fi

# 1️⃣ Instalar x11vnc
echo "📦 Instalando x11vnc..."
sudo pacman -S --noconfirm x11vnc

# 2️⃣ Crear carpeta de contraseñas
echo "🔑 Creando contraseña para VNC..."
mkdir -p "$HOME_DIR/.vnc"
x11vnc -storepasswd "$HOME_DIR/.vnc/passwd"
chmod 600 "$HOME_DIR/.vnc/passwd"
sudo chown -R "$USUARIO:$USUARIO" "$HOME_DIR/.vnc"

# 3️⃣ Crear servicio systemd
SERVICE_FILE="/etc/systemd/system/x11vnc.service"
echo "📝 Creando servicio en $SERVICE_FILE ..."
sudo bash -c "cat > $SERVICE_FILE" <<EOF
[Unit]
Description=Servidor VNC (x11vnc)
After=display-manager.service

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth $HOME_DIR/.vnc/passwd -rfbport 5900 -shared
User=$USUARIO
Environment=DISPLAY=:0
Restart=on-failure

[Install]
WantedBy=graphical.target
EOF

# 4️⃣ Recargar systemd, habilitar y arrancar
echo "⚙️ Activando servicio..."
sudo systemctl daemon-reload
sudo systemctl enable x11vnc.service
sudo systemctl start x11vnc.service

# 5️⃣ Estado
echo "✅ Instalación completa. Estado del servicio:"
sudo systemctl status x11vnc.service --no-pager
