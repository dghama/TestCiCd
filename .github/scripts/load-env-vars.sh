# #!/bin/bash

# set -e

# # Adjust the path to your .env file if necessary
# ENV_FILE=".env"

# if [ -f "$ENV_FILE" ]; then
#   while IFS='=' read -r key value; do
#     # Remove any leading/trailing whitespace from key or value
#     key=$(echo $key | tr -d '[:space:]')
#     value=$(echo $value | tr -d '[:space:]')
#     echo "Setting environment variable: $key"
#     echo "$key=$value" >> $GITHUB_ENV
#   done < "$ENV_FILE"
# else
#   echo "Error: $ENV_FILE not found."
#   exit 1
# fi

