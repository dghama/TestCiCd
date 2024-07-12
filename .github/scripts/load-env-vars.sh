#!/bin/bash

set -e

# Adjust the path to your .env file
ENV_FILE=".env"

if [ -f "$ENV_FILE" ]; then
  LOAD_ENV="${ENV_FILE}"
  echo "ENV=${LOAD_ENV}" >> $GITHUB_ENV
  source "$ENV_FILE"
  export $(cut -d= -f1 "$ENV_FILE")
else
  echo "Error: $ENV_FILE not found."
  exit 1
fi
