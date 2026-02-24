#!/bin/bash
set -e

echo "Applying Kanban module to Chatwoot..."

# Check if Kanban module directory exists
if [ ! -d "/app/app/javascript/modules" ]; then
  mkdir -p /app/app/javascript/modules
fi

# Copy Kanban module files
echo "Copying Kanban module files..."
cp -r /app/docker/kanban-module/* /app/app/javascript/modules/ 2>/dev/null || echo "No Kanban module files to copy"

# Update Chatwoot configuration if needed
echo "Configuring Kanban module..."
if [ -f "/app/docker/kanban-config.js" ]; then
  cp /app/docker/kanban-config.js /app/app/javascript/modules/config.js
fi

echo "Kanban module applied successfully!"