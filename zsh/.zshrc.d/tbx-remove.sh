# Remove a toolbox container, its configuration file, and its isolated data directory.
function tbx-remove() {
  # Prevent running this command from inside a container
  if [ -f /run/.containerenv ]; then
    echo "⚠️  Error: You are currently inside a container."
    echo "   Please 'exit' to the host before removing a toolbox."
    return 1
  fi

  local SEPARATOR="----------------------------------------"

  local TOOLBOX_NAME="$1"
  local TOOLBOX_FOLDER="$TOOLBOX_ENVS_FOLDER/$TOOLBOX_NAME"

  local IMAGE_TAG="toolbox-$TOOLBOX_NAME"

  # --- Safety Checks ---

  # Check if name provided
  if [ -z "$TOOLBOX_NAME" ]; then
    echo "❌ Error: Container name not provided."
    echo "   Usage: tbx-remove <name>"
    return 1
  fi

  # Check if anything exists to delete
  local CONTAINER_EXISTS=false
  if toolbox list -c 2>/dev/null | grep -q "$TOOLBOX_NAME"; then
    CONTAINER_EXISTS=true
  fi

  local IMAGE_EXISTS=false
  if toolbox list -i 2>/dev/null | grep -q "$IMAGE_TAG"; then
    IMAGE_EXISTS=true
  fi

  if [ ! -d "$TOOLBOX_FOLDER" ] && [ "$CONTAINER_EXISTS" = false ]; then
    echo "❌ Error: No container or toolbox environment directory found for '$TOOLBOX_NAME'."
    return 1
  fi

  # --- Confirmation ---

  echo "🔥 You are about to COMPLETELY DESTROY the environment: '$TOOLBOX_NAME'"
  echo "   This will delete:"
  echo "   1. The Toolbox container (Podman)"
  echo "   2. The Toolbox image (Podman)"
  echo "   3. The Toolbox environment directory: $TOOLBOX_FOLDER (includes all Toolbox related data)"
  echo ""

  echo -n "Are you sure you want to proceed? [y/N] "
  if [ -n "$ZSH_VERSION" ]; then
    read -k 1 -r REPLY
  else
    read -n 1 -r REPLY
  fi
  echo

  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "🚫 Operation cancelled."
    return 1
  fi

  echo "$SEPARATOR"

  # --- Execution ---

  # 1. Remove Container
  if [ "$CONTAINER_EXISTS" = true ]; then
    echo "📦 Removing toolbox container..."
    # --force stops the container if it is running
    if toolbox rm --force "$TOOLBOX_NAME"; then
      echo "   ✅ Container deleted."
    else
      echo "   ❌ Failed to delete container."
    fi
  else
    echo "ℹ️  Container not found (skipping)."
  fi

  # 2. Remove Image
  if [ "$IMAGE_EXISTS" = true ]; then
    echo "🖼️  Removing toolbox image..."
    if podman rmi "$IMAGE_TAG"; then
      echo "   ✅ Image deleted."
    else
      echo "   ❌ Failed to delete image."
    fi
  else
    echo "ℹ️  Image not found (skipping)."
  fi

  # 3. Remove Data Directory
  if [ -d "$TOOLBOX_FOLDER" ]; then
    rm -rf "$TOOLBOX_FOLDER"
    echo "🗑️  Isolated environment directory removed."
  else
    echo "ℹ️  Environment directory not found (skipping)."
  fi

  echo "$SEPARATOR"
  echo "💀 Environment '$TOOLBOX_NAME' has been terminated."
}
