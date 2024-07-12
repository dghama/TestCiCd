#!/bin/bash

set -e

# Adjust the path to your .env file
ENV_FILE=".env"

if [ -f "$ENV_FILE" ]; then
  source "$ENV_FILE"
  export $(cut -d= -f1 "$ENV_FILE")
else
  echo "Error: $ENV_FILE not found."
  exit 1
fi
