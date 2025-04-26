#!/bin/bash

# Log startup info
echo "Starting Grafana with environment: $GRAFANA_ENV"

# Set default environment if not specified
ENV_DIR="/opt/grafana/config/${GRAFANA_ENV:-server}"

# Check if environment directory exists
if [ ! -d "$ENV_DIR" ]; then
  echo "ERROR: Environment directory $ENV_DIR does not exist!"
  exit 1
fi

# Copy configuration files
if [ -f "$ENV_DIR/grafana.ini" ]; then
  echo "Copying $ENV_DIR/grafana.ini to /etc/grafana/"
  cp "$ENV_DIR/grafana.ini" /etc/grafana/
fi

if [ -f "$ENV_DIR/grafana.db" ]; then
  echo "Copying $ENV_DIR/grafana.db to /var/lib/grafana/"
  cp "$ENV_DIR/grafana.db" /var/lib/grafana/
  chmod 644 /var/lib/grafana/grafana.db
fi

# Start Grafana
exec /run.sh "$@"
