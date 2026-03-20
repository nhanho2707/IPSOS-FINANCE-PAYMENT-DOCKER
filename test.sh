#!/bin/bash
# Initial test script for IPSOS-FINANCE-PAYMENT-DOCKER

set -e

echo "Running initial tests..."

# Check that required files exist
if [ -f "README.md" ]; then
  echo "PASS: README.md exists"
else
  echo "FAIL: README.md not found"
  exit 1
fi

echo "All tests passed."
