# Contributing to Dix Oracle Core

Thank you for your interest in contributing to Dix Oracle Core! This guide will help you get started.

## Getting Started

1. **Fork the repository**
2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR-USERNAME/Vital-Frecuency.git
   cd Vital-Frecuency
   ```
3. **Install dependencies**:
   ```bash
   ./install.sh  # Linux/Mac
   # or
   install.bat   # Windows
   ```

## Development Workflow

### 1. Create a Branch
```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

### 2. Make Your Changes

Follow the code style and conventions used in the project:

#### Frontend (web/)
- Use TypeScript
- Follow React best practices
- Use functional components with hooks
- Material-UI components preferred
- Format with Prettier (if configured)

#### Backend (api-server/)
- Use JavaScript (or TypeScript if converting)
- Follow Express.js conventions
- Add error handling
- Document API endpoints

#### AI Engine (core-ai/)
- Use Python 3.8+ features
- Follow PEP 8 style guide
- Add type hints where applicable
- Document functions with docstrings

### 3. Test Your Changes

#### Web Module
```bash
cd web
npm run lint
npm run build
npm run dev  # Manual testing
```

#### API Server
```bash
cd api-server
npm run dev  # Start and test manually
```

#### AI Engine
```bash
cd core-ai
python -m pytest  # If tests exist
```

### 4. Commit Your Changes

Follow conventional commits:

```bash
git add .
git commit -m "feat: add new feature description"
# or
git commit -m "fix: fix bug description"
# or
git commit -m "docs: update documentation"
```

**Commit Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

### 5. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub.

## Code Style Guidelines

### TypeScript/JavaScript
- Use `const` and `let`, avoid `var`
- Use arrow functions where appropriate
- Use async/await instead of callbacks
- Add JSDoc comments for functions
- Keep functions small and focused

### Python
- Follow PEP 8
- Use type hints
- Use descriptive variable names
- Add docstrings to functions
- Keep functions under 50 lines when possible

### General
- Write self-documenting code
- Add comments for complex logic
- Keep files under 300 lines
- One component per file (React)
- Use meaningful file names

## Project Structure

```
DixOracleCore/
├── web/              # Frontend React app
│   ├── src/
│   │   ├── pages/    # Page components
│   │   ├── components/ # Reusable components
│   │   └── ...
├── api-server/       # Backend API
│   ├── src/
│   │   ├── routes/   # API routes
│   │   ├── middleware/ # Express middleware
│   │   └── ...
├── core-ai/          # AI/ML engine
├── desktop/          # Electron app
└── android/          # Android app
```

## Adding New Features

### Frontend Features
1. Create new components in `web/src/components/`
2. Add new pages in `web/src/pages/`
3. Update routes in `web/src/App.tsx`
4. Add to navigation if needed

### Backend Features
1. Create new routes in `api-server/src/routes/`
2. Add middleware in `api-server/src/middleware/`
3. Update main server file to register routes
4. Document API endpoints

### AI Features
1. Add new endpoints in `core-ai/main.py`
2. Create model modules in separate files
3. Update requirements.txt if needed
4. Document model inputs/outputs

## Testing

### Manual Testing Checklist
- [ ] Web app loads without errors
- [ ] All navigation links work
- [ ] Forms submit correctly
- [ ] API endpoints respond as expected
- [ ] Error handling works
- [ ] Mobile responsive (web)
- [ ] Cross-browser compatible

### Future: Automated Testing
We plan to add:
- Unit tests (Jest for React, pytest for Python)
- Integration tests
- E2E tests (Playwright/Cypress)

## Documentation

When adding features, update:
- [ ] README.md (if it affects setup)
- [ ] QUICKSTART.md (if it affects usage)
- [ ] ARCHITECTURE.md (if it changes architecture)
- [ ] Code comments
- [ ] API documentation

## Pull Request Process

1. **Update documentation** if needed
2. **Ensure code builds** without errors
3. **Test manually** in your environment
4. **Create PR** with clear description:
   - What changes were made
   - Why they were needed
   - How to test them
5. **Address review feedback**
6. **Squash commits** if requested

## Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring

## Testing
How to test these changes:
1. Step 1
2. Step 2

## Checklist
- [ ] Code builds successfully
- [ ] Tested locally
- [ ] Documentation updated
- [ ] No breaking changes (or documented)
```

## Code Review

Expect:
- Feedback on code style
- Suggestions for improvements
- Questions about implementation
- Requests for tests or documentation

Be open to feedback and discussion!

## Common Issues

### Build Failures
- Clear node_modules and reinstall: `rm -rf node_modules && npm install`
- Check Node.js version: `node --version` (should be 18+)
- Check for typos in imports

### Dependency Issues
- Update package-lock.json: `npm install`
- Check for version conflicts
- Clear npm cache: `npm cache clean --force`

### Git Issues
- Sync with main branch: `git pull origin main`
- Resolve merge conflicts carefully
- Don't force push to shared branches

## Getting Help

- Check existing issues on GitHub
- Read documentation (README, QUICKSTART, ARCHITECTURE)
- Ask questions in pull request comments
- Contact maintainers if needed

## Code of Conduct

- Be respectful and professional
- Help others learn and grow
- Accept constructive criticism
- Focus on the code, not the person
- Collaborate, don't compete

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (UNLICENSED - private project).

---

Thank you for contributing to Dix Oracle Core! 🚀
