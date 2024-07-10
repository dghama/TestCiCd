#!/bin/bash
yarn lint
if [ $? -ne 0 ]; then
  echo "Linting failed!"
  exit 1  # Set custom exit code for errors
fi
