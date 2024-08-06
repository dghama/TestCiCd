#!/bin/bash

# Exit on error
set -e

# Define the repository URL
REPO_URL=$(git config --get remote.origin.url)

# Define the directories and files to exclude
EXCLUDES=(
  .git
  .github
  node_modules
  android
  ios
  tests
  docs
  # Add more files or directories to exclude here
)

# Create a new directory for the clean repository
mkdir clean-repo
cd clean-repo

# Initialize a new git repository
git init

# Add the remote origin
git remote add origin "$REPO_URL"

# Fetch all branches and tags
git fetch origin

# Checkout the main branch (or the branch you want to mirror)
git checkout -b main origin/main

# Remove the excluded directories and files
for EXCLUDE in "${EXCLUDES[@]}"; do
  rm -rf "$EXCLUDE"
done

# Optional: You can remove untracked files and directories
git clean -fdx

# Zip the clean repository
cd ..
zip -r clean-repo.zip clean-repo

# Clean up
rm -rf clean-repo
