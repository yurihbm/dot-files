# Create a new toolbox container and its associated configuration file.
function tbx-create() {
  # Prevent running this command from inside a container
  if [ -f /run/.containerenv ]; then
    echo "⚠️  Error: You are currently inside a container."
    echo "   Please 'exit' to the host before removing a toolbox."
    return 1
  fi

  # Ensure required global variables are set to avoid path issues
  if [ -z "${TOOLBOX_ENVS_FOLDER:-}" ] || [ -z "${TOOLBOX_TEMPLATE_FOLDER:-}" ]; then
    echo "❌ Error: Global variables TOOLBOX_ENVS_FOLDER or TOOLBOX_TEMPLATE_FOLDER are not set."
    return 1
  fi

  # Variables used in the function
  local SEPARATOR="----------------------------------------"

  local TOOLBOX_NAME="$1"
  # Remove trailing slashes from inputs just in case
  TOOLBOX_NAME=${TOOLBOX_NAME%/}
  local CUSTOM_CONTAINERFILE_PATH="$2"

  local TOOLBOX_FOLDER="$TOOLBOX_ENVS_FOLDER/$TOOLBOX_NAME"

  local XDG_CONFIG_HOME="$TOOLBOX_FOLDER/config"
  local XDG_DATA_HOME="$TOOLBOX_FOLDER/data"
  local XDG_STATE_HOME="$TOOLBOX_FOLDER/state"
  local XDG_CACHE_HOME="$TOOLBOX_FOLDER/cache"

  local TEMPLATE_ZSH_FILE="$TOOLBOX_TEMPLATE_FOLDER/template.sh"
  local TEMPLATE_CONFIG_FOLDER="$TOOLBOX_TEMPLATE_FOLDER/config"
  local TEMPLATE_CONTAINERFILE=${CUSTOM_CONTAINERFILE_PATH:-"$TOOLBOX_TEMPLATE_FOLDER/Containerfile.base"}

  local DEST_ZSH_FILE="$TOOLBOX_FOLDER/.zshrc"
  local DEST_CONFIG_FOLDER="$TOOLBOX_FOLDER/config"

  local IMAGE_TAG="toolbox-$TOOLBOX_NAME"

  local SKIP_ROLLBACK=0

  # Rollback function to clean up in case of errors
  function _tbx_rollback() {
    if [ -d "$TOOLBOX_FOLDER" ]; then
      rm -rf "$TOOLBOX_FOLDER"
      echo "🧹 Removed toolbox environment directory."
    fi

    if toolbox list -c 2>/dev/null | grep -q "$TOOLBOX_NAME"; then
      toolbox rm --force "$TOOLBOX_NAME" >/dev/null 2>&1
      echo "📦 Removed toolbox."
    fi

    if toolbox list -i 2>/dev/null | grep -q "$IMAGE_TAG"; then
      podman rmi "$IMAGE_TAG" >/dev/null 2>&1
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

    if [ ! -f "$TEMPLATE_ZSH_FILE" ] || [ ! -f "$TEMPLATE_CONTAINERFILE" ]; then
      echo "❌ Error: Required template or Containerfile not found."
      SKIP_ROLLBACK=1
      return 1
    fi

    # If container or config already exists, prompt for deletion
    if toolbox list -c 2>/dev/null | grep -q "$TOOLBOX_NAME" || [ -f "$TOOLBOX_FOLDER" ]; then
      echo "⚠️  Warning: A toolbox or config named '$TOOLBOX_NAME' already exists."
      echo -n "🔥 Do you want to DELETE the existing one and proceed? [y/N] "
      if [ -n "$ZSH_VERSION" ]; then
        read -k 1 -r REPLY
      else
        read -n 1 -r REPLY
      fi
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

    podman build -t "$IMAGE_TAG" -f "$TEMPLATE_CONTAINERFILE" "$(dirname "$TEMPLATE_CONTAINERFILE")" || return 1

    echo $SEPARATOR
    echo "📦  Creating toolbox container '$TOOLBOX_NAME'..."

    toolbox create -i "$IMAGE_TAG" "$TOOLBOX_NAME" || return 1

    echo "$SEPARATOR"
    echo "📝 Generating toolbox configuration files..."

    # Create toolbox environment directory
    mkdir -p "$TOOLBOX_FOLDER"

    # Create isolated XDG directories
    mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

    sed "s/FILE_TOOLBOX_NAME=\"_template\"/FILE_TOOLBOX_NAME=\"$TOOLBOX_NAME\"/" "$TEMPLATE_ZSH_FILE" >"$DEST_ZSH_FILE"

    if [ -s "$DEST_ZSH_FILE" ]; then
      echo "✅ Configuration file created at $DEST_ZSH_FILE"
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
