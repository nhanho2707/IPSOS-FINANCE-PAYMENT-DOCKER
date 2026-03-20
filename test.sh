#!/bin/bash
# Test script for IPSOS-FINANCE-PAYMENT-DOCKER

set -e

echo "Running Docker infrastructure tests..."

# Check that required files exist
check_file() {
  if [ -f "$1" ]; then
    echo "PASS: $1 exists"
  else
    echo "FAIL: $1 not found"
    exit 1
  fi
}

check_dir() {
  if [ -d "$1" ]; then
    echo "PASS: $1 directory exists"
  else
    echo "FAIL: $1 directory not found"
    exit 1
  fi
}

# Root-level Docker files
check_file "README.md"
check_file "docker-compose.yml"
check_file ".env.example"
check_file ".gitignore"

# Backend files
check_dir "backend"
check_file "backend/Dockerfile"
check_file "backend/.env.docker"
check_file "backend/docker-entrypoint.sh"
check_file "backend/composer.json"
check_file "backend/artisan"

# Frontend files
check_dir "frontend"
check_file "frontend/Dockerfile"
check_file "frontend/package.json"

# Database files
check_dir "database"
check_file "database/schema.sql"

# MySQL init scripts
check_dir "mysql/init"
check_file "mysql/init/01-init.sql"

# Validate docker-compose.yml has required services
if grep -q "frontend:" docker-compose.yml && \
   grep -q "backend:" docker-compose.yml && \
   grep -q "mysql:" docker-compose.yml; then
  echo "PASS: docker-compose.yml contains all required services (frontend, backend, mysql)"
else
  echo "FAIL: docker-compose.yml is missing required services"
  exit 1
fi

echo ""
echo "All tests passed."
