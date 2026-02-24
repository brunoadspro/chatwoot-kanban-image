#!/bin/sh
set -eu

ROLE="${KANBAN_ROLE:-rails}"
MARKER="/app/.kanban-installed-${ROLE}"

if [ ! -f "$MARKER" ]; then
  echo "==> Aplicando módulo Kanban (${ROLE})..."

  if [ "$ROLE" = "sidekiq" ]; then
    export KANBAN_SKIP_MIGRATIONS=true
    export KANBAN_SKIP_ASSETS=true
  else
    export KANBAN_SKIP_MIGRATIONS=false
    export KANBAN_SKIP_ASSETS=false
  fi

  /usr/local/bin/apply-kanban-module.sh
  touch "$MARKER"
else
  echo "==> Módulo Kanban já aplicado neste container (${ROLE})"
fi

exec "$@"