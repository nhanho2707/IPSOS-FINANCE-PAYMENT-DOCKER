# IPSOS Finance Payment — Docker Setup

A fully Dockerized version of the [IPSOS Finance Payment](https://github.com/nhanho2707/IPSOS-FINANCE-PAYMENT) application. The project consists of three services:

- **Frontend** — React (TypeScript) app, served on port `3000`
- **Backend** — Laravel (PHP 8.2) REST API, served on port `8000`
- **Database** — MySQL 8.0, accessible on port `3307`

---

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) ≥ 20.x
- [Docker Compose](https://docs.docker.com/compose/install/) ≥ 2.x

---

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/nhanho2707/IPSOS-FINANCE-PAYMENT-DOCKER.git
cd IPSOS-FINANCE-PAYMENT-DOCKER
```

### 2. Configure environment

```bash
cp .env.example .env
# Edit .env to adjust ports or passwords if needed
```

### 3. Build and start all services

```bash
docker compose up --build
```

The following URLs will be available:

| Service  | URL                       |
|----------|---------------------------|
| Frontend | http://localhost:3000     |
| Backend  | http://localhost:8000     |
| MySQL    | localhost:3307            |

### 4. Stop all services

```bash
docker compose down
```

To also remove the database volume:

```bash
docker compose down -v
```

---

## Service Details

### Backend (Laravel)

The backend Dockerfile is located at `backend/Dockerfile`. On startup, the entrypoint script (`backend/docker-entrypoint.sh`) will:

1. Copy `backend/.env.docker` to `.env` if no `.env` is present
2. Generate the `APP_KEY`
3. Wait for MySQL to be ready
4. Run database migrations (`php artisan migrate --force`)
5. Start the PHP built-in server on port `8000`

To customise the backend environment, edit `backend/.env.docker`.

### Frontend (React)

The frontend Dockerfile is located at `frontend/Dockerfile`. It starts the React development server on port `3000`. The frontend connects to the backend API at `http://localhost:8000` (configurable in `frontend/src/config/ApiConfig.ts`).

### Database (MySQL)

The MySQL service uses the `mysql:8.0.21` image. Initialisation scripts are placed in `mysql/init/` and are executed automatically on first startup.

Database connection defaults (from `.env.example`):

| Variable             | Default           |
|----------------------|-------------------|
| `MYSQL_ROOT_PASSWORD`| `secret`          |
| `MYSQL_DATABASE`     | `finance_payment` |
| `MYSQL_PORT`         | `3307`            |

---

## Project Structure

```
.
├── backend/                # Laravel PHP application
│   ├── Dockerfile          # Backend Docker image
│   ├── docker-entrypoint.sh# Startup script
│   ├── .env.docker         # Docker-specific environment variables
│   └── ...                 # Laravel source code
├── frontend/               # React TypeScript application
│   ├── Dockerfile          # Frontend Docker image
│   └── ...                 # React source code
├── database/               # Database reference files
│   ├── schema.sql          # Database schema
│   ├── backup_file.sql     # Full database backup
│   └── query.sql           # Utility queries
├── mysql/
│   └── init/               # MySQL initialisation scripts
├── docker-compose.yml      # Orchestration for all services
├── .env.example            # Environment variable template
└── README.md
```
