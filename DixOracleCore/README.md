# Dix Oracle Core

**Plataforma multiplataforma para análisis avanzado en tiempo real de partidas MOBA usando IA, overlay y APIs modernas.**

## Módulos

- `web/` — React PWA, overlay, UI, TensorFlow.js
- `api-server/` — Backend Express, MongoDB, OAuth, JWT, Sentry
- `core-ai/` — FastAPI, TensorFlow, YOLO, OpenCV, ONNX, Ultralytics
- `desktop/` — Electron
- `android/` — WebView wrapper

## Instalación rápida

### Backend
```bash
cd DixOracleCore/api-server && npm install && npm run dev
```

### Núcleo IA
```bash
cd DixOracleCore/core-ai && python -m venv venv && source venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload --host 0.0.0.0 --port 8080
```

### Web
```bash
cd DixOracleCore/web && npm install && npm run dev
```

### Desktop
```bash
cd DixOracleCore/desktop && npm install && npm start
```

### Android
```bash
cd DixOracleCore/android
# Abre el proyecto en Android Studio o compila con:
./gradlew assembleDebug
```

## Arquitectura

### Frontend Web (PWA)
- **Framework**: React 18 + TypeScript
- **Bundler**: Vite
- **UI Library**: Material-UI (MUI) v5
- **Routing**: React Router v6
- **State Management**: Zustand
- **HTTP Client**: Axios + TanStack Query
- **AI/ML**: TensorFlow.js + COCO-SSD
- **Monitoring**: Sentry
- **i18n**: i18next + react-i18next

### API Server (Backend)
- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: MongoDB + Mongoose
- **Authentication**: Passport.js (JWT, Google, Steam, Twitch)
- **Security**: Helmet, CORS, Express Rate Limit
- **File Upload**: Multer
- **Monitoring**: Sentry

### Core AI (Python)
- **Framework**: FastAPI
- **Server**: Uvicorn
- **Computer Vision**: OpenCV, Ultralytics YOLO
- **Deep Learning**: TensorFlow, PyTorch
- **Runtime**: ONNX Runtime
- **Image Processing**: Pillow
- **ML Tools**: scikit-learn
- **Monitoring**: Sentry SDK

### Desktop Client
- **Framework**: Electron
- **Builder**: Electron Builder
- **Web Integration**: Carga la PWA localmente

### Android App
- **Language**: Kotlin
- **Wrapper**: WebView con JavaScript habilitado
- **Target SDK**: 34
- **Min SDK**: 24

## Características

### 🎮 Análisis de Partidas MOBA
- Detección en tiempo real de eventos del juego
- Análisis de estadísticas y métricas
- Overlay transparente sobre el juego
- Reportes detallados post-partida

### 🤖 Inteligencia Artificial
- Detección de objetos con YOLO
- Clasificación de imágenes con TensorFlow
- Análisis predictivo de partidas
- Recomendaciones personalizadas

### 🔐 Seguridad y Autenticación
- OAuth 2.0 con múltiples proveedores
- JWT para sesiones seguras
- Rate limiting para prevenir abuso
- Monitoreo con Sentry

### 📱 Multiplataforma
- Web (PWA) - Compatible con todos los navegadores modernos
- Desktop - Windows, macOS, Linux vía Electron
- Android - App nativa con WebView
- API REST - Accesible desde cualquier cliente

## Desarrollo

### Estructura del Proyecto
```
DixOracleCore/
├── web/                    # Frontend PWA
│   ├── src/
│   │   ├── pages/         # Páginas de la aplicación
│   │   ├── components/    # Componentes reutilizables
│   │   ├── App.tsx        # Componente raíz
│   │   ├── main.tsx       # Punto de entrada
│   │   └── theme.ts       # Tema de Material-UI
│   ├── public/            # Archivos estáticos
│   ├── index.html         # HTML principal
│   ├── package.json       # Dependencias Node
│   ├── tsconfig.json      # Configuración TypeScript
│   └── vite.config.ts     # Configuración Vite
│
├── api-server/            # Backend Node.js
│   ├── src/
│   │   └── index.js       # Servidor Express
│   ├── package.json       # Dependencias
│   └── .env.example       # Variables de entorno ejemplo
│
├── core-ai/               # Núcleo de IA Python
│   ├── main.py            # API FastAPI
│   └── requirements.txt   # Dependencias Python
│
├── desktop/               # Cliente Electron
│   ├── main.js            # Proceso principal Electron
│   └── package.json       # Dependencias
│
└── android/               # App Android
    ├── app/
    │   ├── src/main/
    │   │   ├── java/com/dixoraclecore/
    │   │   │   └── MainActivity.kt
    │   │   └── AndroidManifest.xml
    │   └── build.gradle
    ├── build.gradle
    └── settings.gradle
```

### Variables de Entorno

#### API Server (.env)
```env
PORT=4000
MONGO_URL=mongodb://localhost:27017/dix-oracle-core
SENTRY_DSN=your_sentry_dsn_here
JWT_SECRET=your_jwt_secret_here
```

#### Core AI
Configure `SENTRY_DSN` directamente en `main.py` o use variables de entorno.

### Scripts Disponibles

#### Web
- `npm run dev` - Servidor de desarrollo
- `npm run build` - Build de producción
- `npm run preview` - Preview del build
- `npm run lint` - Linter ESLint

#### API Server
- `npm run dev` - Modo desarrollo con nodemon
- `npm start` - Modo producción

#### Core AI
- `uvicorn main:app --reload` - Servidor de desarrollo
- `uvicorn main:app --host 0.0.0.0 --port 8080` - Producción

#### Desktop
- `npm start` - Iniciar Electron

## Roadmap

- [x] Estructura base del proyecto
- [x] Configuración de módulos
- [ ] Implementar autenticación completa
- [ ] Integrar detección de juegos
- [ ] Desarrollar overlay transparente
- [ ] Entrenar modelos de IA personalizados
- [ ] Sistema de reportes avanzado
- [ ] Modo multijugador/colaborativo
- [ ] Monetización y planes premium
- [ ] Internacionalización completa

## Tecnologías Clave

### Frontend
- React 18
- TypeScript
- Material-UI
- TensorFlow.js
- Vite

### Backend
- Node.js
- Express
- MongoDB
- Passport.js
- Sentry

### IA
- Python 3.x
- FastAPI
- TensorFlow
- PyTorch
- YOLO v8
- OpenCV

### Mobile/Desktop
- Electron
- Android/Kotlin
- WebView

## Contribuir

1. Fork el proyecto
2. Crea una rama feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Añade nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## Licencia

Todos los derechos reservados © 2024 Dix Oracle Core

## Soporte

Para soporte y preguntas, contacta al equipo de desarrollo.
