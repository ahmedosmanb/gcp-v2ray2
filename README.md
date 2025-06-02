
# ⚡ VLESS sobre WebSocket (WS) en Google Cloud Run + CDN

Este proyecto permite desplegar un servidor **proxy VLESS** sobre **WebSocket**, usando **Xray-core**, completamente contenedorizado con Docker y desplegado en **Google Cloud Run**, con CDN de **Google Cloud** al frente.

---

## 🌟 Características

- ✔️ VLESS sobre WebSocket (WS)
- ✔️ Desplegado en Google Cloud Run (sin servidor + autoescalado)
- ✔️ Funciona con el Balanceador de Carga + CDN de Google Cloud
- ✔️ Dockerizado y fácil de desplegar
- ✔️ Diseñado para domain fronting, evasión y FreeNet

---

## ⚠️ Aviso Importante

- ❌ Las IPs de Google Cloud que comienzan con `34.*` y `35.*` **NO funcionan** de forma fiable con V2Ray/VLESS.
- ✅ Usa un **dominio personalizado con HTTPS** mediante **Google Load Balancer + CDN** para un funcionamiento correcto.

---

## 🔧 Resumen de Configuración

### `config.json`

```json
{
  "inbounds": [
    {
      "port": 8080,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "abcd1234-ef56-7890-abcd-1234567890ff",
            "level": 0
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/BlackSutra"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
```

> 🔐 Reemplaza el UUID con uno propio por seguridad.

---

## 🐳 Despliegue con Docker

### Paso 1: Construir la imagen Docker

```bash
docker build -t gcr.io/ID_de_Tu_Proyecto/vless-ws .
```

### Paso 2: Subirla al Container Registry

```bash
docker push gcr.io/ID_de_Tu_Proyecto/vless-ws
```

### Paso 3: Desplegar en Google Cloud Run

```bash
gcloud run deploy vless-ws \
  --image gcr.io/ID_de_Tu_Proyecto/vless-ws \
  --platform managed \
  --region us-east1 \
  --allow-unauthenticated \
  --port 8080
```

> ☑️ Asegúrate de permitir **acceso no autenticado**.

---

## 🌐 Configurar CDN + Balanceador de Carga

1. Ve a **Google Cloud Console > Network services > Load balancing**
2. Crea un nuevo **HTTP(S) Load Balancer**
3. Añade tu servicio de **Cloud Run** como backend
4. **Activa CDN** en el backend
5. Adjunta un **dominio personalizado** y un **certificado SSL**

> 🔒 HTTPS es gestionado por Google; no necesitas configurar TLS en Xray.

---

## 📲 Configuración del Cliente (V2Ray, Xray)

Usa los siguientes datos en tu app cliente:

| Parámetro  | Valor                                  |
|------------|----------------------------------------|
| Protocolo  | VLESS                                  |
| Dirección  | `tu.dominio.com`                      |
| Puerto     | `443` (HTTPS)                          |
| UUID       | `abcd1234-ef56-7890-abcd-1234567890ff` |
| Encriptado | none                                   |
| Transporte | WebSocket (WS)                         |
| Ruta WS    | `/BlackSutra`                           |
| TLS        | Sí (mediante Google CDN)               |

---

## 🧪 Clientes Probados

* ✅ **Windows**: V2RayN  
* ✅ **Android**: HTTP Custom / V2RayNG  
* ✅ **iOS**: Shadowrocket / V2Box  
* ✅ **macOS/Linux**: Xray CLI

---

## 🛡 Consejos para Mayor Discreción

* Usa UUIDs y rutas WS aleatorias
* Combínalo con DNS de Cloudflare y proxy
* Rota los dominios si es necesario
* Activa logs solo en entornos de depuración

---

## 📄 Licencia

Este proyecto está licenciado bajo la **Licencia MIT**.

---

## 👤 Autor

Hecho con ❤️ por 🇬🇹 [Christopher] 🇬🇹

---
