#!/bin/bash


# Adjust the path to your .env file if necessary
ENV=$(basename "${GITHUB_REPOSITORY}")
echo "APP_NAME=${ENV}" >> $GITHUB_ENV