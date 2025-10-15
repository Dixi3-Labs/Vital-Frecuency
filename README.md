# Dix Oracle Core

**Plataforma multiplataforma para análisis avanzado en tiempo real de partidas MOBA usando IA, overlay y APIs modernas.**

## Módulos

- `web/` — React PWA, overlay, UI, TensorFlow.js
- `api-server/` — Backend Express, MongoDB, OAuth, JWT, Sentry
- `core-ai/` — FastAPI, TensorFlow, YOLO, OpenCV, ONNX, Ultralytics
- `desktop/` — Electron
- `android/` — WebView wrapper

## Estructura del Proyecto

```
DixOracleCore/
├── web/           # Frontend PWA
├── android/       # Android Studio wrapper
├── core-ai/       # Python IA core
├── api-server/    # Node.js backend
├── desktop/       # Electron client
└── README.md
```

## Instalación rápida

**Para instrucciones detalladas, consulta [QUICKSTART.md](QUICKSTART.md)**

### Backend (api-server)
```bash
cd api-server
npm install
cp .env.example .env
# Editar .env con tus configuraciones
npm run dev
```

### Núcleo IA (core-ai)
```bash
cd core-ai
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload --host 0.0.0.0 --port 8080
```

### Web (Frontend)
```bash
cd web
npm install
npm run dev
```

### Desktop (Electron)
```bash
cd desktop
npm install
npm start
```

### Android
Abrir el proyecto `android/` en Android Studio y ejecutar.

## Características

- **Análisis en tiempo real** con IA
- **Overlay para juegos MOBA**
- **Autenticación OAuth** (Google, Steam, Twitch)
- **Dashboard interactivo** con React + Material-UI
- **API RESTful** con Express y MongoDB
- **Machine Learning** con TensorFlow y YOLO
- **Multiplataforma**: Web, Desktop, Android

## Tecnologías

- **Frontend**: React, TypeScript, Vite, Material-UI
- **Backend**: Node.js, Express, MongoDB, Passport
- **IA**: Python, FastAPI, TensorFlow, YOLO, OpenCV
- **Desktop**: Electron
- **Mobile**: Android (Kotlin + WebView)
- **Monitoring**: Sentry
- **Security**: Helmet, JWT, Rate Limiting

## Desarrollo

Cada módulo tiene sus propios scripts de desarrollo:

- `web/`: `npm run dev` (Puerto 5173)
- `api-server/`: `npm run dev` (Puerto 4000)
- `core-ai/`: `uvicorn main:app --reload` (Puerto 8080)
- `desktop/`: `npm start`

## Licencia

Privado. Todos los derechos reservados.
