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
