#!/bin/bash

# Usa valores por defecto si no están definidos
DHOST=${DHOST:-"127.0.0.1"}
DPORT=${DPORT:-"1080"}
PORT=${PORT:-"8080"}  # Puerto que Cloud Run inyecta

# Genera el config.json dinámicamente
cat > /etc/v2ray/config.json <<EOF
{
  "inbounds": [
    {
      "port": $PORT,
      "listen": "0.0.0.0",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "4cf09c72-f801-44b8-af32-16c984d928d8",
            "level": 0,
            "email": "user@example.com"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/vless"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {
        "redirect": "$DHOST:$DPORT"
      }
    }
  ]
}
EOF

# Ejecuta v2ray
exec v2ray run -config /etc/v2ray/config.json
