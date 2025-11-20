#!/bin/bash

# Load variables from a .env file into the current shell session.
load-env() {
  local env_file="$1"

  if [[ -z "$env_file" ]]; then
    echo "Error: .env file path not provided." >&2
    return 1
  fi

  if [[ ! -f "$env_file" ]]; then
    echo "Error: file '$env_file' not found." >&2
    return 1
  fi

  echo "Loading environment variables from $env_file:"

  local regex='^([A-Za-z0-9_]+)[[:space:]]*=[[:space:]]*([A-Za-z0-9_]+|".+"|'.+')[[:space:]]*(#.*)?$'

  while IFS= read -r line || [[ -n "$line" ]]; do
    # Trim leading/trailing whitespace.
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"

    # Skip blank lines and comments.
    [[ -z "$line" || "$line" == \#* ]] && continue

    # Remove 'export' if present.
    line="${line#export }"

    # Extract variable name and value.
    if [[ "$line" =~ $regex ]]; then
      var_name="${match[1]}"
      var_value="${match[2]}"

      # Remove inline comment if present.
      var_value="${var_value%%#*}"

      # Trim leading/trailing whitespace (due to inline comments).
      var_value="${var_value#"${var_value%%[![:space:]]*}"}"
      var_value="${var_value%"${var_value##*[![:space:]]}"}"

      # Remove surrounding quotes (single or double).
      if [[ "$var_value" =~ \".*\"$ ]]; then
        var_value="${var_value:1:-1}"
      elif [[ "$var_value" =~ \'*\'$ ]]; then
        var_value="${var_value:1:-1}"
      fi

      # Expand escape sequences if double quoted.
      if [[ "$var_value" == *'\'* ]]; then
        var_value=$(printf "%b" "$var_value")
      fi

      if [[ -n "$var_name" ]]; then
        echo "$var_name=$var_value"
        export "$var_name=$var_value"
      fi
    fi
  done <"$env_file"
}

# Unload all environment variables declared in a .env file.
unload-env() {
  local env_file="$1"

  if [[ -z "$env_file" ]]; then
    echo "Error: .env file path not provided." >&2
    return 1
  fi

  if [[ ! -f "$env_file" ]]; then
    echo "Error: file '$env_file' not found." >&2
    return 1
  fi

  echo "Unloading environment variables from $env_file:"

  local regex='^([A-Za-z0-9_]+)[[:space:]]*='

  while IFS= read -r line || [[ -n "$line" ]]; do
    # Trim leading/trailing whitespace.
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"

    # Skip blank lines and comments.
    [[ -z "$line" || "$line" == \#* ]] && continue

    # Remove 'export' if present.
    line="${line#export }"

    # Extract variable name only.
    if [[ "$line" =~ $regex ]]; then
      var_name="${match[1]}"
      echo "$var_name"
      unset "$var_name"
    fi
  done <"$env_file"
}

# Create a new toolbox container and its associated configuration file.
function tbx-create() {
  # Variables used in the function
  local SEPARATOR="----------------------------------------"
  local TOOLBOX_NAME="$1"
  local TOOLBOX_FOLDER="$TOOLBOX_ENVS_FOLDER/$TOOLBOX_NAME"

  local TEMPLATE_FILE="$TOOLBOX_TEMPLATE_FOLDER/template.sh"
  local TEMPLATE_CONFIG_FOLDER="$TOOLBOX_TEMPLATE_FOLDER/config"
  local TEMPLATE_CONTAINERFILE="$TOOLBOX_TEMPLATE_FOLDER/Containerfile.base"

  local DEST_FILE="$TOOLBOX_FOLDER/.bashrc"
  local DEST_CONFIG_FOLDER="$TOOLBOX_FOLDER/config"

  local SKIP_ROLLBACK=0

  # Rollback function to clean up in case of errors
  function _tbx_rollback() {
    if [ -d "$TOOLBOX_FOLDER" ]; then
      rm -rf "$TOOLBOX_FOLDER"
      echo "🧹 Removed toolbox environment directory."
    fi

    if toolbox list 2>/dev/null | grep -q "$TOOLBOX_NAME"; then
      toolbox rm --force "$TOOLBOX_NAME" >/dev/null 2>&1
      echo "📦 Removed toolbox."
    fi

  }

  # Main creation function
  function _tbx_create() {
    # --- Validation checks ---
    if [ -z "$TOOLBOX_NAME" ]; then
      echo "❌ Error: Toolbox name not provided."
      SKIP_ROLLBACK=1
      return 1
    fi

    if [ ! -f "$TEMPLATE_FILE" ] || [ ! -f "$TEMPLATE_CONTAINERFILE" ]; then
      echo "❌ Error: Required template or Containerfile not found."
      SKIP_ROLLBACK=1
      return 1
    fi

    # If container or config already exists, prompt for deletion
    if toolbox list 2>/dev/null | grep -q "$TOOLBOX_NAME" || [ -f "$TOOLBOX_FOLDER" ]; then
      echo "⚠️  Warning: A toolbox or config named '$TOOLBOX_NAME' already exists."
      read -p "🔥 Do you want to DELETE the existing one and proceed? [y/N] " -n 1 -r
      echo

      # If user does not confirm, cancel operation
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "🚫 Operation cancelled by user. Nothing was changed."
        SKIP_ROLLBACK=1
        return 1
      fi

      # User confirmed deletion, perform rollback
      echo "♻️  Cleaning up old environment before creation..."
      _tbx_rollback
    fi

    # --- Execution ---

    echo $SEPARATOR
    echo "🏗️  Building toolbox base image..."

    podman build -t toolbox-base -f "$TEMPLATE_CONTAINERFILE" "$(dirname "$TEMPLATE_CONTAINERFILE")" || return 1

    echo $SEPARATOR
    echo "📦  Creating toolbox container '$TOOLBOX_NAME'..."

    toolbox create -i toolbox-base "$TOOLBOX_NAME" || return 1

    echo "$SEPARATOR"
    echo "📝 Generating toolbox configuration files..."

    mkdir -p "$TOOLBOX_FOLDER"

    sed "s/FILE_TOOLBOX_NAME=\"_template\"/FILE_TOOLBOX_NAME=\"$TOOLBOX_NAME\"/" "$TEMPLATE_FILE" >"$DEST_FILE"

    if [ -s "$DEST_FILE" ]; then
      echo "✅ Configuration file created at $DEST_FILE"
    else
      echo "❌ Error: Failed to create configuration file."
      return 1
    fi

    cp -r "$TEMPLATE_CONFIG_FOLDER" "$DEST_CONFIG_FOLDER"

    if [ -d "$DEST_CONFIG_FOLDER" ]; then
      echo "✅ Configuration folder copied to $DEST_CONFIG_FOLDER"
    else
      echo "❌ Error: Failed to copy configuration folder."
      return 1
    fi

    echo "$SEPARATOR"
    echo "🎉 Toolbox '$TOOLBOX_NAME' created successfully!"
  }

  # Execute the creation process with error handling
  if ! _tbx_create; then
    if [ "$SKIP_ROLLBACK" -eq 0 ]; then
      echo "⚠️  An error occurred during creation. Rolling back changes..."
      _tbx_rollback
      echo "✅ System state restored."
    fi
    return 1
  fi
}

# Remove a toolbox container, its configuration file, and its isolated data directory.
function tbx-remove() {
  local SEPARATOR="----------------------------------------"
  local TOOLBOX_NAME="$1"
  local TOOLBOX_FOLDER="$TOOLBOX_ENVS_FOLDER/$TOOLBOX_NAME"

  # --- Safety Checks ---

  # Check if name provided
  if [ -z "$TOOLBOX_NAME" ]; then
    echo "❌ Error: Container name not provided."
    echo "   Usage: tbx-remove <name>"
    return 1
  fi

  # Prevent running this command from inside a container
  if [ -f /run/.containerenv ]; then
    echo "⚠️  Error: You are currently inside a container."
    echo "   Please 'exit' to the host before removing a toolbox."
    return 1
  fi

  # Check if anything exists to delete
  local container_exists=false
  if toolbox list 2>/dev/null | grep -q "$TOOLBOX_NAME"; then
    container_exists=true
  fi

  if [ ! -d "$TOOLBOX_FOLDER" ] && [ "$container_exists" = false ]; then
    echo "❌ Error: No container or toolbox environment directory found for '$TOOLBOX_NAME'."
    return 1
  fi

  # --- Confirmation ---

  echo "🔥 You are about to COMPLETELY DESTROY the environment: '$TOOLBOX_NAME'"
  echo "   This will delete:"
  echo "   1. The Toolbox container (Podman)"
  echo "   3. The Toolbox environment directory: $TOOLBOX_FOLDER (includes all Toolbox related data)"
  echo ""

  read -p "Are you sure you want to proceed? [y/N] " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "🚫 Operation cancelled."
    return 1
  fi

  echo "$SEPARATOR"

  # --- Execution ---

  # 1. Remove Container
  if [ "$container_exists" = true ]; then
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
