# Ultra Bootstrap Script - Usage Guide

## Overview

The `ultra_bootstrap_all.sh` script is a comprehensive monorepo/multi-repo bootstrap solution that creates and manages 5 specialized repositories with complete codebases, AI integrations, monetization systems, and production-ready infrastructure.

## Repositories Created

| Repository | Type | Description |
|------------|------|-------------|
| `auditAI` | Node.js Backend | GRC platform with AI dual feedback, risk analysis, and monetization |
| `ghostNoize` | Flutter Mobile | Urban acoustic intelligence with ML on-device classification |
| `sussuratoAI` | Flutter Mobile | Generative music co-producer with infinite feedback loops |
| `infraDev` | Electron Desktop | Technical diagnostic agent with auto-fix AI capabilities |
| `spectrumNexus` | Flutter Mobile | RF/AR sensory augmentation with AI and monetization |

## Prerequisites

### Required Tools
```bash
# Install GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh

# Authenticate with GitHub
gh auth login

# Install Node.js (>=20)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Flutter (optional, for Flutter apps)
snap install flutter --classic
```

### Authentication Setup
```bash
# For SSH (recommended)
ssh-keygen -t ed25519 -C "your_email@example.com"
gh ssh-key add ~/.ssh/id_ed25519.pub

# For HTTPS (alternative)
gh auth token  # Use personal access token
```

## Usage Examples

### Basic Usage
```bash
# Make script executable
chmod +x ultra_bootstrap_all.sh

# Run with default settings (creates repos for user 'Dixiegamer')
./ultra_bootstrap_all.sh

# Use custom GitHub username
./ultra_bootstrap_all.sh --user=yourusername
```

### Advanced Usage
```bash
# Dry run - see what would be created without making changes
./ultra_bootstrap_all.sh --dry-run

# Force overwrite existing files
./ultra_bootstrap_all.sh --force

# Use HTTPS instead of SSH for git operations
./ultra_bootstrap_all.sh --https

# Combine multiple flags
./ultra_bootstrap_all.sh --dry-run --https --user=mycompany
```

### Environment Variables
```bash
# Override default GitHub user
export GH_USER_OVERRIDE="myorganization"
./ultra_bootstrap_all.sh
```

## Generated Project Structure

### auditAI (Node.js Backend)
```
auditAI/
├── api/
│   ├── src/
│   │   ├── main.ts              # Application entry point with Sentry
│   │   ├── server.ts            # Express server setup
│   │   ├── routes/
│   │   │   ├── health.ts        # Health check endpoint
│   │   │   └── risk.ts          # Risk analysis API
│   │   ├── core/
│   │   │   └── riskEngine.ts    # ML-based risk assessment
│   │   ├── ia/
│   │   │   ├── feedback.ts      # AI feedback system
│   │   │   └── triggerFeedback.js # CI integration
│   │   ├── monetization/
│   │   │   ├── aiPricing.ts     # Dynamic pricing engine
│   │   │   └── scheduler.ts     # Monetization schedulers
│   │   └── middleware/
│   │       └── errorHandler.ts # Global error handling
│   └── tests/
│       └── risk.test.ts         # Test suite
├── package.json                 # Dependencies & scripts
├── tsconfig.json               # TypeScript configuration
├── jest.config.js              # Testing configuration
├── Dockerfile                  # Production container
└── .github/workflows/ci.yml    # CI/CD pipeline
```

### Flutter Apps (ghostNoize, sussuratoAI, spectrumNexus)
```
{app_name}/
├── lib/
│   ├── main.dart               # Application entry point
│   └── src/
│       ├── ai/
│       │   └── feedback.dart   # AI feedback system
│       ├── monetization/
│       │   └── revenue.dart    # RevenueCat integration
│       └── ml/
│           └── stub_classifier.dart # ML classification
├── pubspec.yaml                # Flutter dependencies
├── analysis_options.yaml      # Dart analyzer config
└── .github/workflows/ci.yml   # Flutter CI/CD
```

### infraDev (Electron Desktop)
```
infraDev/
├── src/
│   ├── main.ts                 # Electron main process
│   ├── perf/
│   │   └── monitor.ts          # System performance monitoring
│   └── ai/
│       └── feedback.ts         # AI diagnostic feedback
├── package.json                # Electron dependencies
├── tsconfig.json              # TypeScript configuration
└── .github/workflows/ci.yml   # Electron CI/CD
```

## Features Implemented

### 🤖 AI & Machine Learning
- **Dual AI Provider Support**: ChatGPT and Grok API integrations
- **Intelligent Feedback Loops**: Automatic error reporting and fix suggestions
- **ML Classification**: On-device machine learning for Flutter apps
- **Risk Analysis Engine**: Advanced risk assessment algorithms
- **Performance Monitoring**: AI-driven system diagnostics

### 💰 Monetization & Business Logic
- **Dynamic Pricing**: AI-powered pricing optimization
- **Revenue Integration**: Stripe (backend) and RevenueCat (mobile) support
- **Subscription Management**: Premium feature unlocking
- **Upsell Detection**: Automated conversion opportunity identification
- **Usage Analytics**: Revenue optimization insights

### 🛡️ Security & Monitoring
- **Sentry Integration**: Real-time error tracking and reporting
- **Environment Isolation**: Secure secret management with .env
- **Input Sanitization**: Protection against data leaks
- **Role-Based Access**: Security by design
- **Audit Logging**: Comprehensive activity tracking

### 🔧 Development Experience
- **TypeScript First**: Full type safety across all projects
- **Automated Testing**: Jest testing framework setup
- **Code Quality**: ESLint, Prettier, and Husky pre-commit hooks
- **CI/CD Pipelines**: GitHub Actions workflows for all project types
- **Docker Support**: Production-ready containerization
- **Hot Reload**: Development server with automatic restart

### 📱 Cross-Platform Support
- **Mobile**: Flutter apps with native iOS and Android support
- **Desktop**: Electron apps for Windows, macOS, and Linux
- **Backend**: Scalable Node.js APIs with Express
- **Containerized**: Docker deployment ready

## Configuration

### Environment Variables (.env files created)
```bash
# AI Providers
LLM_PROVIDER_API_KEY=your_openai_key
GROK_API_KEY=your_grok_key

# Monitoring
SENTRY_DSN=https://your_dsn@sentry.io/123456

# Monetization
STRIPE_API_KEY=your_stripe_key
REVENUECAT_API_KEY=your_revenuecat_key
ENABLE_DYNAMIC_PRICING=true

# Database
DATABASE_URL=postgres://user:pass@localhost:5432/app
```

### Dynamic Pricing Configuration
```typescript
// Automatic pricing adjustments based on:
- Usage patterns and user behavior
- Market conditions and competition
- Conversion rates and churn analysis
- AI-driven recommendations with confidence scoring
```

## Development Workflow

### 1. Initial Setup
```bash
# Run bootstrap script
./ultra_bootstrap_all.sh --user=yourorg

# Navigate to any repo
cd auditAI

# Install dependencies (automatically done by script)
npm install

# Start development
npm run dev
```

### 2. AI Feedback Integration
```bash
# Manual trigger AI feedback analysis
npm run ai:feedback

# View AI suggestions in logs
tail -f logs/ai-feedback.log
```

### 3. Testing & Deployment
```bash
# Run tests
npm test

# Build production
npm run build

# Deploy with Docker
docker build -t auditai .
docker run -p 3000:3000 auditai
```

## Idempotent Design

The script can be run multiple times safely:
- ✅ Existing repositories are preserved
- ✅ Existing files are not overwritten (unless `--force`)
- ✅ Dependencies are reinstalled/updated
- ✅ Git changes are committed incrementally

## Troubleshooting

### Common Issues

1. **GitHub Authentication Failed**
   ```bash
   gh auth login
   gh auth status
   ```

2. **Permission Denied (SSH)**
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   gh ssh-key add ~/.ssh/id_ed25519.pub
   # Or use --https flag
   ```

3. **Flutter Not Found**
   ```bash
   snap install flutter --classic
   flutter doctor
   ```

4. **Node.js Version Issues**
   ```bash
   node --version  # Should be >= 20
   npm --version
   ```

### Debug Mode
```bash
# Enable verbose output
set -x
./ultra_bootstrap_all.sh --dry-run
set +x
```

## Extending the Script

### Adding New Repository Types
```bash
# In ultra_bootstrap_all.sh, add to REPO_TYPES
declare -A REPO_TYPES=(
  [newRepo]="custom-type"
)

# Create new generator function
write_custom_type() {
  local r="$1"
  # Implementation here
}

# Add to main switch statement
case "$type" in
  custom-type) write_custom_type "$repo" ;;
esac
```

### Customizing Templates
- Modify generator functions (`write_auditAI`, `write_flutter_app`, etc.)
- Update common templates (`gen_common_readme`, `gen_env_example_common`)
- Add new CI/CD pipeline templates

## Support and Contribution

For issues, features, or contributions:
1. Create issues in the main repository
2. Submit pull requests with detailed descriptions
3. Follow the existing code style and patterns
4. Include tests for new functionality

## License

Private - All rights reserved. See individual repository licenses for specific terms.