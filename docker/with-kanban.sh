#!/bin/bash
set -e

echo "Starting Chatwoot with Kanban module..."

# Apply Kanban module configuration
bash /app/docker/apply-kanban-module.sh

# Start Chatwoot
exec "$@"