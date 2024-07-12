#!/bin/bash

set -e

# Adjust the path to your .env file
ENV_FILE=".env"

if [ -f "$ENV_FILE" ]; then
  echo "found: $(cat $ENV_FILE | grep -v '^#' | xargs) found."
  export $(cat $ENV_FILE | grep -v '^#' | xargs)
else
  echo "Error: $ENV_FILE not found."
  exit 1
fi
