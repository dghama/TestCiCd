#!/bin/bash

# Set APP_NAME based on repository name without username
APP_NAME=$(basename "${GITHUB_REPOSITORY}")
echo "APP_NAME=${APP_NAME}" >> $GITHUB_ENV
