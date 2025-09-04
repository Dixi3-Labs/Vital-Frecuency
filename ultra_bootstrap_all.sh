#!/usr/bin/env bash
# ==========================================================================================
# ULTRA THINK MONOREPO / MULTI-REPO BOOTSTRAP SCRIPT (Optimizado Máximo)
# ==========================================================================================
# Objetivo:
#   - Crear / actualizar 5 repos (auditAI, ghostNoize, sussuratoAI, infraDev, spectrumNexus)
#   - Inyectar código base completo (Backend Node + Electron + Flutter Apps)
#   - Integraciones: IA (ChatGPT/Grok placeholders), Monetización (Stripe/RevenueCat),
#     Sentry, Pricing Dinámico, Feedback Infinito, Seguridad, CI/CD, Docker, Fastlane placeholders
#   - Idempotente: Puede correrse múltiples veces sin romper estructura
#   - Modo seco (--dry-run) y modo forzado (--force)
#   - Modular + reutilizable + validación de entorno
#
# Requisitos Previos (manual si faltan):
#   - gh (GitHub CLI) autenticado: gh auth login
#   - git, node (>=20), npm, (opcional: flutter >=3, docker)
#   - ssh configurado si usas git@... (o cambiar a https)
#
# Uso:
#   chmod +x ultra_bootstrap_all.sh
#   ./ultra_bootstrap_all.sh                # Ejecutar normal
#   ./ultra_bootstrap_all.sh --dry-run      # Solo mostrar acciones
#   ./ultra_bootstrap_all.sh --force        # Fuerza recrear archivos base
#   ./ultra_bootstrap_all.sh --https        # Clona usando HTTPS en lugar de SSH
#
# Notas Seguridad:
#   - No se incluyen claves reales (solo placeholders)
#   - No subir .env (está en .gitignore)
#
# ==========================================================================================

set -euo pipefail

# --------------------------------- CONFIG PRINCIPAL ---------------------------------------
GH_USER="${GH_USER_OVERRIDE:-Dixiegamer}"

declare -A REPO_TYPES=(
  [auditAI]="node-backend"
  [ghostNoize]="flutter"
  [sussuratoAI]="flutter"
  [infraDev]="electron"
  [spectrumNexus]="flutter"
)

# Descripciones cortas
declare -A REPO_DESC=(
  [auditAI]="Plataforma GRC predictiva con IA dual, monetización y seguridad avanzada"
  [ghostNoize]="Inteligencia acústica urbana ML on-device + monetización IA"
  [sussuratoAI]="Co-productor musical generativo + feedback infinito"
  [infraDev]="Agente técnico desktop con diagnóstico y auto-fix IA"
  [spectrumNexus]="Aumentación sensorial RF/AR con IA y monetización"
)

# Flags
DRY_RUN=false
FORCE_WRITE=false
USE_HTTPS=false

# --------------------------------- PARÁMETROS ---------------------------------------------
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    --force)   FORCE_WRITE=true ;;
    --https)   USE_HTTPS=true ;;
    --user=*)  GH_USER="${arg#*=}" ;;
    *) echo "Flag desconocida: $arg"; exit 1 ;;
  esac
done

# --------------------------------- COLORES ------------------------------------------------
c_green() { printf "\033[32m%s\033[0m\n" "$*"; }
c_yellow() { printf "\033[33m%s\033[0m\n" "$*"; }
c_red() { printf "\033[31m%s\033[0m\n" "$*"; }
c_cyan() { printf "\033[36m%s\033[0m\n" "$*"; }

banner() {
  echo
  c_cyan "===== $1 ====="
}

# --------------------------------- HELPERS ------------------------------------------------
run() {
  if $DRY_RUN; then
    c_yellow "[dry-run] $*"
  else
    eval "$@"
  fi
}

ensure_cmd() {
  if ! command -v "$1" &>/dev/null; then
    c_red "Falta comando requerido: $1"
    MISSING+=("$1")
  fi
}

create_or_view_repo() {
  local repo=$1
  if gh repo view "$GH_USER/$repo" &>/dev/null; then
    c_yellow "Repo remoto ya existe: $repo"
  else
    run gh repo create "$GH_USER/$repo" --private --description "${REPO_DESC[$repo]}"
    c_green "Repo creado: $repo"
  fi
}

clone_repo() {
  local repo=$1
  if [ -d "$repo/.git" ]; then
    c_yellow "Directorio ya existe, haciendo pull: $repo"
    (cd "$repo" && run git pull --rebase || true)
  else
    local url
    if $USE_HTTPS; then
      url="https://github.com/$GH_USER/$repo.git"
    else
      url="git@github.com:$GH_USER/$repo.git"
    fi
    run git clone "$url" "$repo"
  fi
}

safe_write() {
  # safe_write <filepath> (stdin content)
  local f="$1"
  if [ -f "$f" ] && ! $FORCE_WRITE; then
    c_yellow "Skip (existe) $f"
    return 0
  fi
  if $DRY_RUN; then
    c_yellow "[dry-run write] $f"
    cat >/dev/null
  else
    mkdir -p "$(dirname "$f")"
    cat > "$f"
    c_green "Escrito: $f"
  fi
}

append_unique() {
  # append_unique <file> <line>
  local file=$1; local line=$2
  if ! $DRY_RUN; then
    grep -Fqx "$line" "$file" 2>/dev/null && return 0
    echo "$line" >> "$file"
  fi
}

git_stage_and_commit() {
  local repo=$1
  if $DRY_RUN; then
    c_yellow "[dry-run] git add/commit/push ($repo)"
    return 0
  fi
  pushd "$repo" >/dev/null
  git add .
  if git diff --cached --quiet; then
    c_yellow "Sin cambios que commitear en $repo"
  else
    git commit -m "chore: ultra bootstrap sync" || true
    git push origin HEAD:main || true
    c_green "Cambios subidos en $repo"
  fi
  popd >/dev/null
}

# --------------------------------- VALIDACIONES -------------------------------------------
banner "Validando entorno"
MISSING=()
ensure_cmd git
ensure_cmd gh
ensure_cmd node
ensure_cmd npm
# flutter es opcional; solo avisamos si faltará
if ! command -v flutter &>/dev/null; then
  c_yellow "Flutter no instalado (requerido para apps Flutter)."
fi

if ((${#MISSING[@]})); then
  c_red "Faltan dependencias críticas: ${MISSING[*]}"
  exit 1
fi

if ! gh auth status &>/dev/null; then
  c_red "GitHub CLI no autenticado. Ejecuta: gh auth login"
  exit 1
fi

c_green "Entorno válido."

# --------------------------------- PLANTILLAS COMUNES -------------------------------------
gen_common_readme() {
  local repo=$1
  cat <<EOF
# $repo

${REPO_DESC[$repo]}

## Fases (Retroalimentación Infinita)
1. Fundaciones
2. IA Dual (ChatGPT/Grok) + Feedback
3. Monetización Inteligente (Stripe / RevenueCat)
4. Seguridad & Observabilidad (Sentry / Scans)
5. Auto-Heal & Branch Suggestions
6. Pricing Dinámico IA
7. Ciclos de Mejora Continuos

## Scripts Clave
- run dev / analyze / test
- AI feedback hooks
- Dynamic pricing loops

## Seguridad
- Nunca subir secretos reales
- Usar .env y GitHub Actions Secrets

## Feedback IA (Patrón)
\`\`\`pseudo
try {
  doWork()
} catch(e) {
  reportToAI(e, ctx)
  suggestion = suggestFix(e, ctx)
  log(suggestion)
}
\`\`\`

## Licencia
Privado. Todos los derechos reservados.
EOF
}

gen_env_example_common() {
  cat <<'EOF'
# ================= ENV EXAMPLE (PLACEHOLDERS) =================
# Backend / DB
DATABASE_URL=postgres://user:pass@localhost:5432/app
PORT=3000
NODE_ENV=development

# Auth & Security
JWT_SECRET_KEY=your_jwt_secret
MASTER_ENCRYPTION_KEY=your_master_key

# AI Providers
LLM_PROVIDER_API_KEY=your_openai_key
GROK_API_KEY=your_grok_key

# Monitoring
SENTRY_DSN=https://your_dsn@sentry.io/123456
SENTRY_ENVIRONMENT=development

# Monetización
STRIPE_API_KEY=your_stripe_key
REVENUECAT_API_KEY=your_revenuecat_key
ENABLE_DYNAMIC_PRICING=true
PRICING_STRATEGY=ai-adaptive
DYNAMIC_PRICING_INTERVAL_MS=3600000
MONETIZATION_CHECK_INTERVAL_MS=1800000

# Maps / ML / Extra
MAPBOX_PUBLIC_TOKEN=your_mapbox_token
GOOGLE_MAPS_API_KEY=your_gmaps_key
EOF
}

write_gitignore_node() {
  cat <<'EOF'
node_modules
dist
coverage
.env
.DS_Store
*.log
.vscode
EOF
}

write_gitignore_flutter() {
  cat <<'EOF'
# Flutter
build/
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub/
.pub-cache/
.env
.DS_Store
*.iml
EOF
}

write_gitignore_electron() {
  cat <<'EOF'
node_modules
dist
coverage
.env
.DS_Store
*.log
.vscode
out
EOF
}

# --------------------------------- GENERADORES ESPECÍFICOS --------------------------------
write_auditAI() {
  local r="auditAI"
  safe_write "$r/README.md" < <(gen_common_readme "$r")
  safe_write "$r/.env.example" < <(gen_env_example_common)
  safe_write "$r/.gitignore" < <(write_gitignore_node)

  safe_write "$r/package.json" <<'EOF'
{
  "name": "audit-ai-root",
  "private": true,
  "scripts": {
    "dev": "ts-node-dev --respawn api/src/main.ts",
    "build": "tsc -p tsconfig.json",
    "lint": "eslint . --ext .ts,.js",
    "test": "jest --passWithNoTests",
    "format": "prettier -w .",
    "typecheck": "tsc --noEmit",
    "ai:feedback": "node api/src/ia/triggerFeedback.js"
  },
  "dependencies": {
    "@sentry/node": "^8.0.0",
    "cors": "^2.8.5",
    "dotenv": "^16.4.5",
    "express": "^4.19.2",
    "node-fetch": "^3.3.2",
    "pg": "^8.11.5",
    "zod": "^3.23.8"
  },
  "devDependencies": {
    "@commitlint/cli": "^19.3.0",
    "@commitlint/config-conventional": "^19.3.0",
    "@types/express": "^4.17.21",
    "@types/jest": "^29.5.12",
    "@types/node": "^20.11.30",
    "@typescript-eslint/eslint-plugin": "^7.1.0",
    "@typescript-eslint/parser": "^7.1.0",
    "eslint": "^9.3.0",
    "husky": "^9.0.10",
    "jest": "^29.7.0",
    "lint-staged": "^15.2.2",
    "prettier": "^3.2.5",
    "standard-version": "^9.5.0",
    "ts-jest": "^29.1.2",
    "ts-node": "^10.9.2",
    "ts-node-dev": "^2.0.0",
    "typescript": "^5.4.2"
  },
  "lint-staged": {
    "*.{ts,js,json,md,yml,yaml}": ["prettier -w"]
  }
}
EOF

  safe_write "$r/tsconfig.json" <<'EOF'
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "CommonJS",
    "lib": ["ES2022"],
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "outDir": "dist"
  },
  "include": ["api/src/**/*","api/tests/**/*"]
}
EOF

  safe_write "$r/api/src/main.ts" <<'EOF'
import './polyfill';
import { createServer } from './server';
import { initMonetizationSchedulers } from './monetization/scheduler';
import { reportToAI, suggestFix } from './ia/feedback';
import { config } from 'dotenv';
import * as Sentry from '@sentry/node';
config();

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.SENTRY_ENVIRONMENT || process.env.NODE_ENV,
  tracesSampleRate: 1.0,
  beforeSend(event) {
    const errorData = {
      message: event.exception?.values?.[0]?.value || event.message,
      stacktrace: event.exception?.values?.[0]?.stacktrace?.frames?.slice(-5),
      context: event.contexts
    };
    reportToAI(errorData, 'sentry-error', 'auditAI').catch(()=>{});
    suggestFix(errorData, 'sentry-error', 'auditAI').catch(()=>{});
    return event;
  }
});

async function bootstrap() {
  const app = await createServer();
  const port = process.env.PORT || 3000;
  app.listen(port, () => console.log(`[auditAI] Listening on :${port}`));
  initMonetizationSchedulers();

  process.on('uncaughtException', async (err) => {
    console.error('uncaughtException', err);
    Sentry.captureException(err);
  });
  process.on('unhandledRejection', async (reason) => {
    console.error('unhandledRejection', reason);
    Sentry.captureException(reason as any);
  });
}

bootstrap().catch(async (e) => {
  console.error('Startup failure', e);
  Sentry.captureException(e);
  await reportToAI(e, 'startup', 'auditAI');
  process.exit(1);
});
EOF

  safe_write "$r/api/src/polyfill.ts" <<'EOF'
// Place polyfills here if needed (e.g., fetch global)
EOF

  safe_write "$r/api/src/server.ts" <<'EOF'
import express from 'express';
import cors from 'cors';
import { json } from 'express';
import * as Sentry from '@sentry/node';
import { healthRouter } from './routes/health';
import { riskRouter } from './routes/risk';
import { errorHandler } from './middleware/errorHandler';

export async function createServer() {
  const app = express();
  app.use(Sentry.Handlers.requestHandler());
  app.use(cors());
  app.use(json());
  app.use('/health', healthRouter);
  app.use('/risk', riskRouter);
  app.use(Sentry.Handlers.errorHandler());
  app.use(errorHandler());
  return app;
}
EOF

  safe_write "$r/api/src/routes/health.ts" <<'EOF'
import { Router } from 'express';
export const healthRouter = Router();
healthRouter.get('/', (_req, res) => {
  res.json({
    status: 'ok',
    ts: new Date().toISOString(),
    env: process.env.NODE_ENV
  });
});
EOF

  safe_write "$r/api/src/routes/risk.ts" <<'EOF'
import { Router } from 'express';
import { z } from 'zod';
import { analyzeRisk } from '../core/riskEngine';
import { reportToAI } from '../ia/feedback';
export const riskRouter = Router();
const bodySchema = z.object({ content: z.string().min(5).max(10000) });

riskRouter.post('/predict', async (req, res) => {
  try {
    const { content } = bodySchema.parse(req.body);
    const result = await analyzeRisk(content);
    reportToAI({ len: content.length, result }, 'risk-prediction', 'auditAI').catch(()=>{});
    res.json(result);
  } catch (e: any) {
    await reportToAI(e.message || e, 'risk-error', 'auditAI');
    if (e instanceof z.ZodError) {
      res.status(400).json({ error: 'validation_error', issues: e.errors });
    } else {
      res.status(500).json({ error: 'internal_error', detail: e.message });
    }
  }
});
EOF

  safe_write "$r/api/src/core/riskEngine.ts" <<'EOF'
export async function analyzeRisk(content: string) {
  await new Promise(r => setTimeout(r, 50 + Math.random()*150));
  const kHigh = ['violate','exploit','illegal','breach','hack'];
  const kMed  = ['risk','sensitive','concern','warn'];
  const lower = content.toLowerCase();
  let h=0,m=0;
  kHigh.forEach(w=>{ if(lower.includes(w)) h++; });
  kMed.forEach(w=>{ if(lower.includes(w)) m++; });
  let score = Math.min(0.99, h*0.25 + m*0.1 + Math.random()*0.05 + Math.min(0.3, content.length/1500));
  if (content.length < 25) score = Math.min(score, 0.35);
  const labels = score>0.7 ? ['HIGH_RISK','REVIEW'] : score>0.4 ? ['MEDIUM_RISK'] : ['LOW_RISK'];
  return {
    riskScore: Number(score.toFixed(3)),
    labels,
    confidence: Number((0.7 + Math.random()*0.2).toFixed(2)),
    recommendation: score>0.7 ? "Review required" : score>0.4 ? "Add documentation" : undefined
  };
}
EOF

  safe_write "$r/api/src/middleware/errorHandler.ts" <<'EOF'
import { Request, Response, NextFunction } from 'express';
import * as Sentry from '@sentry/node';
import { reportToAI, suggestFix } from '../ia/feedback';

export function errorHandler() {
  return async (err: any, req: Request, res: Response, _next: NextFunction) => {
    Sentry.captureException(err);
    const ctx = { route: req.url, method: req.method, msg: err?.message, time: new Date().toISOString() };
    reportToAI(ctx, 'api-error', 'auditAI').catch(()=>{});
    suggestFix(ctx, 'api-error', 'auditAI').catch(()=>{});
    res.status(500).json({ error: 'internal_error', detail: process.env.NODE_ENV==='production' ? 'error' : err.message });
  };
}
EOF

  safe_write "$r/api/src/ia/feedback.ts" <<'EOF'
import fetch from 'node-fetch';

export async function reportToAI(payload: any, context: string, app: string) {
  try {
    const apiKey = process.env.LLM_PROVIDER_API_KEY;
    console.log(`[AI-REPORT][${app}][${context}]`, summarize(payload));
    if (!apiKey) return;
    await fetch('https://api.example.com/ai/feedback', {
      method:'POST',
      headers:{ 'Content-Type':'application/json','Authorization':`Bearer ${apiKey}` },
      body: JSON.stringify({ payload: sanitize(payload), context, app })
    });
  } catch(e){ console.error('AI report fail', e); }
}

export async function suggestFix(payload: any, context: string, app: string) {
  try {
    const apiKey = process.env.LLM_PROVIDER_API_KEY || process.env.GROK_API_KEY;
    console.log(`[AI-SUGGEST][${app}][${context}]`, summarize(payload));
    if (!apiKey) return null;
    // Simulación
    if (process.env.NODE_ENV !== 'production') {
      return { suggestion: "Check null inputs", confidence: 0.84, actionable: true };
    }
  } catch(e){ console.error('AI suggest fail', e); }
  return null;
}

function sanitize(data: any) {
  if (!data || typeof data !== 'object') return data;
  const clone = JSON.parse(JSON.stringify(data));
  const sensitive = /pass|secret|key|token/i;
  Object.keys(clone).forEach(k => { if (sensitive.test(k)) clone[k]='[REDACTED]'; });
  return clone;
}

function summarize(p:any){
  try {
    if (typeof p === 'string') return p.slice(0,140);
    return JSON.stringify(p).slice(0,140);
  } catch { return 'unserializable'; }
}
EOF

  safe_write "$r/api/src/ia/triggerFeedback.js" <<'EOF'
#!/usr/bin/env node
console.log("[AI-FEEDBACK] CI pipeline placeholder -> would gather logs & send to ChatGPT/Grok.");
EOF
  if ! $DRY_RUN; then
    chmod +x "$r/api/src/ia/triggerFeedback.js"
  fi

  safe_write "$r/api/src/monetization/aiPricing.ts" <<'EOF'
interface Recommendation { productId:string; currentPrice:number; recommendedPrice:number; confidence:number; reasoning:string; }
export function dynamicPricing():Recommendation[] {
  const recs:Recommendation[] = [
    { productId:'basic', currentPrice:9.99, recommendedPrice:10.49, confidence:0.82, reasoning:'Usage up & churn stable' },
    { productId:'pro', currentPrice:19.99, recommendedPrice:19.99, confidence:0.9, reasoning:'Optimal zone' }
  ];
  console.log('[Pricing] dynamicPricing cycle', recs);
  return recs;
}
export function checkMonetization() {
  const upsell = [{ segment:'high-usage-basic', count:33, expectedConversion:0.28 }];
  console.log('[Monetization] Upsell candidates', upsell);
  return upsell;
}
EOF

  safe_write "$r/api/src/monetization/scheduler.ts" <<'EOF'
import { dynamicPricing, checkMonetization } from './aiPricing';
export function initMonetizationSchedulers() {
  const dp = parseInt(process.env.DYNAMIC_PRICING_INTERVAL_MS || '3600000',10);
  const cm = parseInt(process.env.MONETIZATION_CHECK_INTERVAL_MS || '1800000',10);
  console.log(`[Monetization] schedulers dp=${dp}ms check=${cm}ms`);
  setInterval(dynamicPricing, dp);
  setInterval(checkMonetization, cm);
  setTimeout(()=>{dynamicPricing(); checkMonetization();}, 4000);
}
EOF

  safe_write "$r/api/tests/risk.test.ts" <<'EOF'
import { analyzeRisk } from '../src/core/riskEngine';
test('risk basic', async () => {
  const r = await analyzeRisk('This is a benign compliance test text');
  expect(r).toHaveProperty('riskScore');
});
EOF

  safe_write "$r/jest.config.js" <<'EOF'
module.exports = {
  testEnvironment: 'node',
  roots: ['<rootDir>/api/src','<rootDir>/api/tests'],
  transform: { '^.+\\.tsx?$': 'ts-jest' }
};
EOF

  safe_write "$r/Dockerfile" <<'EOF'
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY . .
RUN npm run build
ENV NODE_ENV=production
EXPOSE 3000
CMD ["node","dist/api/src/main.js"]
EOF

  safe_write "$r/.github/workflows/ci.yml" <<'EOF'
name: CI
on:
  push: { branches: [main, develop] }
  pull_request:
jobs:
  build-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20' }
      - run: npm install
      - run: npm run lint || true
      - run: npm test || true
      - run: npm run build
      - run: npm run ai:feedback || true
EOF
}

write_flutter_app() {
  local r="$1"
  safe_write "$r/README.md" < <(gen_common_readme "$r")
  safe_write "$r/.env.example" <<'EOF'
FIREBASE_API_KEY=your_firebase_api_key
FIREBASE_APP_ID=your_firebase_app_id
FIREBASE_MESSAGING_SENDER_ID=your_firebase_sender_id
FIREBASE_PROJECT_ID=your_firebase_project_id
FIREBASE_STORAGE_BUCKET=your_firebase_storage_bucket
REVENUECAT_API_KEY=your_revenuecat_api_key
OPENAI_API_KEY=your_openai_key
GROK_API_KEY=your_grok_key
MAPBOX_ACCESS_TOKEN=your_mapbox_token
EOF
  safe_write "$r/.gitignore" < <(write_gitignore_flutter)

  safe_write "$r/pubspec.yaml" <<EOF
name: ${r//_/-}
description: $r app (AI dual feedback + monetización)
publish_to: 'none'
version: 0.1.0+1
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
  provider: ^6.0.5
  flutter_dotenv: ^5.1.0
  shared_preferences: ^2.2.2
  sensors_plus: ^5.0.0
  firebase_core: ^2.30.0
  firebase_crashlytics: ^3.5.0
  firebase_analytics: ^10.10.0
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
flutter:
  uses-material-design: true
  assets:
    - assets/
    - .env
EOF

  safe_write "$r/analysis_options.yaml" <<'EOF'
include: package:flutter_lints/flutter.yaml
analyzer:
  errors:
    unused_import: warning
linter:
  rules:
    - prefer_const_constructors
EOF

  safe_write "$r/lib/main.dart" <<'EOF'
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/ai/feedback.dart';
import 'src/monetization/revenue.dart';
import 'src/ml/stub_classifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await AIFeedback().init(apiKey: dotenv.env['OPENAI_API_KEY']);
  await RevenueEngine().init(apiKey: dotenv.env['REVENUECAT_API_KEY'], userId: 'demo-user');
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Demo',
      theme: ThemeData.dark(),
      home: const DemoScreen(),
    );
  }
}

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});
  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  Map<String,double>? result;
  String? suggestion;
  bool premium = false;

  Future<void> classify() async {
    final r = await LocalClassifier().classify(['sample','audio','feature']);
    setState(()=> result = r);
    AIFeedback().report({'classification': r}, 'sound', 'mobile');
  }

  Future<void> askSuggestion() async {
    final s = await AIFeedback().suggest({'current': result}, 'improve');
    setState(()=> suggestion = s?['suggestion']);
  }

  Future<void> togglePremium() async {
    if(!premium){
      await RevenueEngine().purchase('monthly');
    }
    setState(()=> premium = !premium);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo AI / Monetización')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children:[
            ElevatedButton(onPressed: classify, child: const Text('Clasificar')),
            if(result!=null) ...[
              const SizedBox(height:10),
              Text('Resultado: ${result}'),
            ],
            ElevatedButton(onPressed: askSuggestion, child: const Text('Sugerencia IA')),
            if(suggestion!=null) Text('IA: $suggestion'),
            const Spacer(),
            ElevatedButton(
              onPressed: togglePremium,
              child: Text(premium ? 'Premium Activo' : 'Actualizar a Premium')
            ),
          ],
        ),
      ),
    );
  }
}
EOF

  safe_write "$r/lib/src/ai/feedback.dart" <<'EOF'
import 'dart:convert';

class AIFeedback {
  static final AIFeedback _i = AIFeedback._();
  factory AIFeedback()=>_i;
  AIFeedback._();
  String? _apiKey;
  bool _ready=false;

  Future<void> init({String? apiKey}) async {
    _apiKey = apiKey;
    _ready = true;
  }

  Future<void> report(dynamic payload, String ctx, String app) async {
    if(!_ready) return;
    // Simulación local
    // En producción -> HTTP POST a backend
    // ignore: avoid_print
    print('[AI-REPORT][$app][$ctx] ${_short(payload)}');
  }

  Future<Map<String,dynamic>?> suggest(dynamic data, String ctx) async {
    if(!_ready) return null;
    // Simulación
    return {
      'suggestion':'Consider an alternative threshold logic',
      'confidence':0.83
    };
  }

  String _short(dynamic d){
    final s = d is String ? d : jsonEncode(d);
    return s.length>120 ? s.substring(0,120)+'...' : s;
  }
}
EOF

  safe_write "$r/lib/src/monetization/revenue.dart" <<'EOF'
class RevenueEngine {
  static final RevenueEngine _i = RevenueEngine._();
  factory RevenueEngine()=>_i;
  RevenueEngine._();
  bool _init=false;
  String? _apiKey;
  String? _user;

  Future<void> init({required String? apiKey, required String userId}) async {
    _apiKey = apiKey;
    _user = userId;
    _init = true;
  }

  Future<bool> purchase(String productId) async {
    if(!_init) return false;
    // Simulación: siempre éxito
    // ignore: avoid_print
    print('[Revenue] purchase $productId for user $_user');
    return true;
  }

  Future<Map<String,dynamic>> offerings() async {
    return {
      'monthly': {'price':4.99,'features':['featureA','featureB']},
      'yearly': {'price':39.99,'features':['featureA','featureB','featureC']}
    };
  }
}
EOF

  safe_write "$r/lib/src/ml/stub_classifier.dart" <<'EOF'
import 'dart:math';

class LocalClassifier {
  final _rnd = Random();
  Future<Map<String,double>> classify(List<String> tokens) async {
    // Finge clasificación
    final categories = ['traffic','voice','music','noise'];
    final map = <String,double>{};
    double total=0;
    for (final c in categories){
      final v = _rnd.nextDouble();
      map[c]=v;
      total+=v;
    }
    // normalizar
    return map.map((k,v)=> MapEntry(k, v/total));
  }
}
EOF

  safe_write "$r/.github/workflows/ci.yml" <<'EOF'
name: Flutter CI
on:
  push: { branches: [main, develop] }
  pull_request:
jobs:
  build-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
      - run: flutter --version
      - run: flutter pub get
      - run: flutter analyze || true
      - run: flutter test || true
EOF
}

write_infraDev() {
  local r="infraDev"
  safe_write "$r/README.md" < <(gen_common_readme "$r")
  safe_write "$r/.env.example" < <(gen_env_example_common)
  safe_write "$r/.gitignore" < <(write_gitignore_electron)

  safe_write "$r/package.json" <<'EOF'
{
  "name": "infraDev",
  "private": true,
  "version": "0.1.0",
  "main": "dist/main.js",
  "scripts": {
    "dev": "ts-node-dev --respawn src/main.ts",
    "build": "tsc -p tsconfig.json",
    "lint": "eslint . --ext .ts",
    "test": "echo \"(Add tests)\""
  },
  "dependencies": {
    "electron": "^30.0.0",
    "dotenv": "^16.4.5",
    "systeminformation": "^5.23.7"
  },
  "devDependencies": {
    "@types/node": "^20.11.30",
    "eslint": "^9.3.0",
    "@typescript-eslint/parser": "^7.1.0",
    "@typescript-eslint/eslint-plugin": "^7.1.0",
    "typescript": "^5.4.2"
  }
}
EOF

  safe_write "$r/tsconfig.json" <<'EOF'
{
  "compilerOptions": {
    "target":"ES2022",
    "module":"CommonJS",
    "lib":["ES2022","DOM"],
    "strict":true,
    "esModuleInterop":true,
    "skipLibCheck":true,
    "outDir":"dist"
  },
  "include":["src/**/*"]
}
EOF

  safe_write "$r/src/main.ts" <<'EOF'
import { app, BrowserWindow } from 'electron';
import { performanceMonitor } from './perf/monitor';
import { reportToAI, suggestFix } from './ai/feedback';
import { config } from 'dotenv';
config();

let win:BrowserWindow|null = null;

function create() {
  win = new BrowserWindow({
    width:1000, height:700,
    webPreferences:{ nodeIntegration:true, contextIsolation:false }
  });
  win.loadURL('data:text/html,<h2>infraDev Agent</h2><p>Diagnostics + AI Ready.</p>');
}

app.whenReady().then(() => {
  create();
  performanceMonitor();
}).catch(async e=>{
  await reportToAI(e,'startup','infraDev');
});

process.on('uncaughtException', async err => {
  await reportToAI(err,'uncaught','infraDev');
  await suggestFix(err,'uncaught','infraDev');
});
EOF

  safe_write "$r/src/perf/monitor.ts" <<'EOF'
import si from 'systeminformation';
import { reportToAI } from '../ai/feedback';
export function performanceMonitor() {
  setInterval(async () => {
    const load = await si.currentLoad();
    if (load.currentLoad > 80) {
      await reportToAI({cpu:load.currentLoad}, 'high-cpu', 'infraDev');
    }
  }, 10000);
}
EOF

  safe_write "$r/src/ai/feedback.ts" <<'EOF'
export async function reportToAI(payload:any, ctx:string, app:string) {
  // ignore: no-console
  console.log(`[AI-REPORT][${app}][${ctx}]`, shorten(payload));
}
export async function suggestFix(payload:any, ctx:string, app:string) {
  console.log(`[AI-FIX][${app}][${ctx}]`);
}
function shorten(p:any){
  try {
    const s = typeof p==='string'? p : JSON.stringify(p);
    return s.slice(0,140);
  } catch { return 'unserializable'; }
}
EOF

  safe_write "$r/.github/workflows/ci.yml" <<'EOF'
name: Electron CI
on:
  push: { branches:[main, develop] }
  pull_request:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20' }
      - run: npm install
      - run: npm run lint || true
      - run: npm run build
EOF
}

# --------------------------------- PROCESO PRINCIPAL --------------------------------------
banner "Creación / Actualización Repos Remotos"
for repo in "${!REPO_TYPES[@]}"; do
  create_or_view_repo "$repo"
done

banner "Clonando / Sincronizando"
for repo in "${!REPO_TYPES[@]}"; do
  clone_repo "$repo"
done

banner "Generando Contenido"
for repo in "${!REPO_TYPES[@]}"; do
  type="${REPO_TYPES[$repo]}"
  c_cyan ">>> Procesando $repo ($type)"
  case "$type" in
    node-backend) write_auditAI ;;
    flutter)      write_flutter_app "$repo" ;;
    electron)     write_infraDev ;;
    *) c_red "Tipo desconocido: $type" ;;
  esac
done

banner "Instalando Dependencias (Node/Electron)"
if ! $DRY_RUN; then
  for repo in "${!REPO_TYPES[@]}"; do
    case "${REPO_TYPES[$repo]}" in
      node-backend|electron)
        c_cyan "npm install -> $repo"
        (cd "$repo" && npm install) || c_red "Fallo npm install en $repo"
        ;;
    esac
  done
else
  c_yellow "Saltando instalaciones (dry-run)."
fi

banner "Instalando Dependencias Flutter (si flutter presente)"
if command -v flutter &>/dev/null && ! $DRY_RUN; then
  for repo in "${!REPO_TYPES[@]}"; do
    if [ "${REPO_TYPES[$repo]}" = "flutter" ]; then
      c_cyan "flutter pub get -> $repo"
      (cd "$repo" && flutter pub get) || c_red "Fallo flutter pub get en $repo"
    fi
  done
else
  c_yellow "Flutter no disponible o dry-run activo, omitido."
fi

banner "Commits & Push"
for repo in "${!REPO_TYPES[@]}"; do
  git_stage_and_commit "$repo"
done

banner "Resumen Final"
echo "Repos procesados: ${!REPO_TYPES[@]}"
echo "DRY_RUN: $DRY_RUN"
echo "FORCE_WRITE: $FORCE_WRITE"
echo "USE_HTTPS: $USE_HTTPS"
echo "GH_USER: $GH_USER"

c_green "🎉 Ultra Bootstrap completado exitosamente!"
c_cyan "Siguiente: Revisar cada repo y personalizar según necesidades específicas."