# Architecture Overview - Dix Oracle Core

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        User Interfaces                          │
├─────────────────┬──────────────────┬──────────────────────────┤
│   Web Browser   │  Desktop App     │    Android Mobile        │
│   (React PWA)   │  (Electron)      │    (WebView)             │
└────────┬────────┴────────┬─────────┴──────────┬───────────────┘
         │                 │                    │
         │                 │                    │
         ├─────────────────┴────────────────────┤
         │                                       │
         ▼                                       ▼
┌─────────────────────────────────────────────────────────────────┐
│                    API Gateway / Load Balancer                  │
└────────┬────────────────────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────────────────────────────┐
│                       API Server (Node.js)                      │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  • Express REST API                                      │  │
│  │  • Authentication (JWT, OAuth)                           │  │
│  │  • Rate Limiting & Security                              │  │
│  │  • Sentry Error Tracking                                 │  │
│  └──────────────────────────────────────────────────────────┘  │
└────────┬──────────────────────┬────────────────────────────────┘
         │                      │
         ▼                      ▼
┌─────────────────┐    ┌──────────────────────────────────────────┐
│    MongoDB      │    │        Core AI Engine (Python)           │
│   Database      │    │  ┌────────────────────────────────────┐  │
│                 │    │  │  • FastAPI                         │  │
│  • User Data    │    │  │  • TensorFlow / PyTorch            │  │
│  • Game Stats   │    │  │  • YOLO Object Detection           │  │
│  • Analytics    │    │  │  • OpenCV Image Processing         │  │
│                 │    │  │  • Real-time Analysis              │  │
└─────────────────┘    │  └────────────────────────────────────┘  │
                       └──────────────────────────────────────────┘
```

## Component Details

### Frontend Layer (web/)
- **Framework**: React 18 + TypeScript
- **Build Tool**: Vite 5
- **UI Library**: Material-UI (MUI) v5
- **State Management**: Zustand
- **API Client**: Axios + React Query
- **Routing**: React Router v6
- **Features**:
  - Responsive PWA design
  - Game overlay system
  - Real-time dashboard
  - Multi-language support (i18next)
  - Client-side ML (TensorFlow.js)

### API Server (api-server/)
- **Runtime**: Node.js 20+
- **Framework**: Express.js
- **Database**: MongoDB (Mongoose ODM)
- **Authentication**: 
  - Passport.js (Google, Steam OAuth)
  - JWT tokens
- **Security**:
  - Helmet.js (HTTP headers)
  - Rate limiting
  - CORS configuration
- **Monitoring**: Sentry
- **Features**:
  - RESTful API
  - User management
  - Game data aggregation
  - Analytics endpoints

### AI Engine (core-ai/)
- **Runtime**: Python 3.8+
- **Framework**: FastAPI
- **ML Libraries**:
  - TensorFlow / PyTorch
  - Ultralytics (YOLO)
  - scikit-learn
  - OpenCV
- **Features**:
  - Image analysis
  - Object detection
  - Real-time inference
  - Model serving

### Desktop App (desktop/)
- **Framework**: Electron 29
- **Purpose**: Native desktop experience
- **Features**:
  - System tray integration
  - Native notifications
  - Auto-updates
  - Offline capabilities

### Mobile App (android/)
- **Platform**: Android (Kotlin)
- **Architecture**: WebView wrapper
- **Features**:
  - Native mobile UI
  - Push notifications
  - Camera integration
  - Background services

## Data Flow

### Game Analysis Flow
```
Game Screenshot → Web/Desktop Client → Core AI Engine
                                      ↓
                           ML Model Analysis (YOLO)
                                      ↓
                           Detection Results
                                      ↓
                          API Server (Storage)
                                      ↓
                        MongoDB (Historical Data)
                                      ↓
                          Client (Display)
```

### Authentication Flow
```
User → Web Client → API Server → Passport.js
                                      ↓
                            OAuth Provider (Google/Steam)
                                      ↓
                              JWT Token
                                      ↓
                          Client (Authenticated)
```

## Technology Stack

### Frontend
- React 18
- TypeScript 5
- Vite 5
- Material-UI v5
- Zustand (state)
- React Query (data fetching)
- TensorFlow.js (client ML)

### Backend
- Node.js 20
- Express 4
- MongoDB 8
- Passport.js (auth)
- Helmet (security)
- Sentry (monitoring)

### AI/ML
- Python 3.8+
- FastAPI
- TensorFlow / PyTorch
- YOLO v8
- OpenCV
- scikit-learn

### Mobile
- Android SDK
- Kotlin
- WebView

### Desktop
- Electron 29
- Node.js integration

## Deployment Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Cloud Provider                        │
│                    (AWS / GCP / Azure)                       │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Frontend   │  │  API Server  │  │  AI Engine   │      │
│  │   (Static)   │  │  (Container) │  │  (GPU VM)    │      │
│  │   S3/CDN     │  │   Kubernetes │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                               │
│  ┌──────────────┐  ┌──────────────┐                        │
│  │   MongoDB    │  │    Sentry    │                        │
│  │   (Atlas)    │  │  (Monitoring)│                        │
│  └──────────────┘  └──────────────┘                        │
└─────────────────────────────────────────────────────────────┘
```

## Security Considerations

1. **Authentication**: Multi-provider OAuth + JWT
2. **Data Protection**: Encrypted at rest and in transit
3. **Rate Limiting**: API endpoint protection
4. **Input Validation**: Server-side validation
5. **CORS**: Configured for specific origins
6. **Security Headers**: Helmet.js implementation
7. **Error Handling**: No sensitive data in responses
8. **Monitoring**: Real-time with Sentry

## Scalability

- **Horizontal Scaling**: API servers behind load balancer
- **Database**: MongoDB sharding for large datasets
- **Caching**: Redis for frequently accessed data
- **CDN**: Static assets served via CDN
- **AI Engine**: GPU instances for ML inference
- **Async Processing**: Queue system for heavy tasks

## Performance Optimization

- **Frontend**: Code splitting, lazy loading
- **API**: Connection pooling, query optimization
- **AI**: Model optimization (ONNX), batch processing
- **Caching**: Multi-layer caching strategy
- **CDN**: Global content delivery

## Monitoring & Observability

- **Error Tracking**: Sentry integration
- **Logging**: Structured logging (JSON)
- **Metrics**: Custom metrics collection
- **Alerts**: Automated alerting system
- **Analytics**: User behavior tracking
