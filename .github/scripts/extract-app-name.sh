# File: scripts/extract-app-name.sh

# Extract the app name from package.json
APP_NAME=$(grep -m1 '"name":' package.json | sed -E 's/.*"name": "([^"]+)".*/\1/')

if [ -z "$APP_NAME" ]; then
  echo "Error: Could not extract app name from package.json"
  exit 1
fi

echo "$APP_NAME"