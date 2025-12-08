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
