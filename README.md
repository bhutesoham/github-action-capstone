# github-actions-capstone

A minimal Python Flask app with a full CI/CD pipeline using GitHub Actions.

## App

One endpoint: `GET /health` — returns a JSON health check response.

```json
{ "status": "ok", "message": "Service is running" }
```

## Project Structure

```
github-actions-capstone/
├── .github/
│   └── workflows/
│       └── ci-cd.yml        # GitHub Actions pipeline
├── tests/
│   └── test_app.py          # pytest tests
├── app.py                   # Flask application
├── Dockerfile               # Container definition
├── requirements.txt         # Production dependencies
├── requirements-dev.txt     # Dev + test dependencies
├── .flake8                  # Linter config
└── .gitignore
```

## CI/CD Pipeline

The workflow runs on every push and PR to `main`:

| Job | Trigger | What it does |
|-----|---------|--------------|
| **Lint** | Every push/PR | Runs `flake8` on app and tests |
| **Test** | After lint passes | Runs `pytest` |
| **Build** | After tests pass | Builds & pushes Docker image to Docker Hub |
| **Deploy** | After build, `main` only | SSHs into server, pulls & restarts container |

## Required GitHub Secrets

Set these in **Settings → Secrets and variables → Actions**:

| Secret | Description |
|--------|-------------|
| `DOCKER_USERNAME` | Your Docker Hub username |
| `DOCKER_PASSWORD` | Your Docker Hub access token |
| `SSH_HOST` | IP or hostname of your deploy server |
| `SSH_USER` | SSH username on the server |
| `SSH_PRIVATE_KEY` | Private key for SSH access |

## Run Locally

```bash
# Install dependencies
pip install -r requirements-dev.txt

# Run the app
python app.py

# Run tests
pytest tests/ -v

# Lint
flake8 app.py tests/

# Build Docker image
docker build -t github-actions-capstone .
docker run -p 5000:5000 github-actions-capstone
```
