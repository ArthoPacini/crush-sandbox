#!/bin/sh
# .devcontainer/prepare-image.sh

# Define the name and tag for our local image
IMAGE_NAME="local/crush-sandbox:latest"

# Check if the image already exists locally
# The 'docker image inspect' command will fail if the image doesn't exist.
if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
  echo "--- Image '$IMAGE_NAME' not found locally. Attempting to build... ---"
  
  # Attempt to build the image. This will use cached layers if available
  # and will only fail if it's offline AND a required resource isn't cached.
  docker build \
    --platform=linux/arm64 \
    -t "$IMAGE_NAME" \
    -f ".devcontainer/Dockerfile" \
    "." # Use the project root as the build context

  # Check if the build command succeeded
  if [ $? -ne 0 ]; then
    echo "--- Build failed. Please check your internet connection or Docker setup. ---"
    exit 1
  fi
else
  echo "--- Found existing image '$IMAGE_NAME'. Skipping build. ---"
fi