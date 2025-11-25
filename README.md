# Dot-Files Configuration

A comprehensive dotfiles repository featuring Fedora Toolbox container management, Zsh configuration, and development environment setup.

## 📁 Repository Structure

```
.
├── config/              # Host machine configuration (GNOME, etc.)
├── gnome/               # GNOME-specific settings
├── icons/               # Custom icon themes
├── postinstall/         # Post-installation setup scripts
├── toolbox/             # Container templates and base images
└── zsh/                 # Zsh shell configuration and functions
```

## 🛠️ Toolbox Container Management

This repository includes a sophisticated system for creating and managing isolated development environments using [Fedora Toolbox](https://docs.fedoraproject.org/en-US/fedora-silverblue/toolbox/) and Podman.

### Architecture Overview

**`.toolbox-envs` Folder Structure**

Each toolbox environment is isolated in `~/.toolbox-envs/<name>/`:

```
~/.toolbox-envs/
├── _template/           # Master template folder
│   ├── Containerfile.base
│   ├── template.sh
│   ├── config/
│   │   ├── nvim/
│   │   ├── starship.toml
│   │   └── tmux/
│   └── .toolbox-envs/
└── <environment-name>/  # Individual toolbox environments
    ├── .zshrc           # Auto-generated, environment-specific zsh config
    ├── config/          # XDG_CONFIG_HOME
    │   ├── nvim/
    │   ├── starship.toml
    │   └── tmux/
    ├── data/            # XDG_DATA_HOME
    ├── state/           # XDG_STATE_HOME (history, session files)
    └── cache/           # XDG_CACHE_HOME
```

**Key Features:**

- **Isolated Environments**: Each toolbox has its own XDG directories (config, data, state, cache)
- **Persistent Configuration**: Shared template configs are copied to each environment during creation
- **Container-Aware Setup**: Configurations auto-detect container context via `$TOOLBOX_NAME`
- **Automatic Initialization**: Oh My Zsh, plugins, and tools (Starship, Mise, Neovim) are set up on first use

### Template System

The template folder (`_template`) serves as the master blueprint:

**`template.sh`** - Master Zsh configuration template

- Detects container context via `$TOOLBOX_NAME` environment variable
- Sets up XDG environment variables for isolated configuration
- Configures Oh My Zsh with plugins (syntax-highlighting, autosuggestions)
- Initializes Starship prompt, Mise version manager, and tool aliases
- Installed to each new container as `.zshrc` with name substitution

**`Containerfile.base`** - Base container image definition

- Built on latest Fedora Toolbox image
- Pre-installs essential tools: Starship, Fd-find, Neovim, Tmux, Mise, Zsh, Pinentry
- Can be overridden with custom Containerfile via `tbx-create` parameter

**`config/`** - Default configurations

- **nvim/**: Neovim config (copied to each environment's `config/nvim/`)
- **starship.toml**: Prompt theme configuration
- **tmux/**: Tmux configuration files

### Creation Function: `tbx-create`

Creates a new isolated Podman-based development environment.

**Usage:**

```bash
tbx-create <name> [custom-containerfile-path]
```

**Parameters:**

- `<name>`: Environment name (required)
- `[custom-containerfile-path]`: Custom Containerfile instead of template default (optional)

**What it does:**

1. **Validation**: Checks prerequisites and global variables (`TOOLBOX_ENVS_FOLDER`, `TOOLBOX_TEMPLATE_FOLDER`)
2. **Conflict Detection**: Prompts if container/config already exists
3. **Image Building**: Builds Podman image tagged `toolbox-<name>`
4. **Container Creation**: Creates Toolbox container from built image
5. **Config Setup**:
   - Creates `~/.toolbox-envs/<name>/` directory structure with XDG folders
   - Generates `.zshrc` from template with name substitution
   - Copies configuration templates to new environment
6. **Rollback**: Cleans up all created resources if any step fails

**Example:**

```bash
# Create a "python" development environment
tbx-create python

# Create with custom Containerfile
tbx-create ml-dev ./custom-Containerfile
```

### Removal Function: `tbx-remove`

Completely removes an environment and all associated data.

**Usage:**

```bash
tbx-remove <name>
```

**What it does:**

1. **Safety Checks**: Verifies container/config exists; prevents running from inside containers
2. **Confirmation**: Shows what will be deleted and requires explicit approval
3. **Cleanup**:
   - Removes Toolbox container (stops if running)
   - Removes Podman image (`toolbox-<name>`)
   - Deletes entire `~/.toolbox-envs/<name>/` directory (all data, configs, cache)

**Example:**

```bash
# Remove a toolbox environment
tbx-remove python
```

### Entering a Toolbox

Once created, enter a toolbox with standard Toolbox commands:

```bash
# List all toolboxes
toolbox list

# Enter a toolbox
toolbox enter <name>

# Run a command in a toolbox
toolbox run -c <name> <command>

# Exit a toolbox
exit
```

### Environment Auto-Configuration

When inside a toolbox container:

1. **Detection**: `$TOOLBOX_NAME` is detected from `/run/.containerenv`
2. **Zshrc Sourcing**: Container-specific `.zshrc` is loaded from `~/.toolbox-envs/<name>/.zshrc`
3. **XDG Setup**: All tools use isolated config/data/state/cache directories
4. **First-Run Setup**: Oh My Zsh and plugins auto-install on first login
5. **Tool Init**: Starship and Mise are initialized with container-specific configs

### Shell Functions Reference

**Load Environment Variables:**

```bash
load-env <path-to-.env-file>
```

Exports all variables from a `.env` file to the current session. Handles quoted strings, comments, and escape sequences.

**Unload Environment Variables:**

```bash
unload-env <path-to-.env-file>
```

Unsets all variables that were previously loaded from a `.env` file.

**Useful Aliases:**

```bash
gac "message"            # git add -A && git commit -m "message"
gll                      # git pull --all
zsh-reload              # Reload zsh configuration
zsh-config              # Edit toolbox zsh config (nvim)
global-zsh-config       # Edit host zsh config (nvim)
tmux "..."              # Use tmux with custom XDG-aware config
pn                      # pnpm shortcut
```

## 🔧 Zsh Configuration

### Directory Structure

```
zsh/
├── .zshrc               # Main configuration file
└── .zshrc.d/            # Auto-loaded configuration modules
    ├── load-env.sh      # Environment variable loader
    ├── unload-env.sh    # Environment variable unloader
    ├── tbx-create.sh    # Create new toolbox function
    ├── tbx-remove.sh    # Remove toolbox function
    └── aliases.sh       # Shell aliases
```

### Global Environment Setup

The main `.zshrc` configures:

- **Toolbox Paths**: Sets `TOOLBOX_ENVS_FOLDER` and `TOOLBOX_TEMPLATE_FOLDER`
- **Container Detection**: Auto-detects running inside Toolbox via `/run/.containerenv`
- **Module Loading**: Auto-sources all scripts from `~/.zshrc.d/`
- **PATH Extensions**: Adds `~/.local/bin` and `~/bin` to PATH
- **GPG Setup**: Exports `GPG_TTY` for terminal-based GPG operations

## 📦 Post-Installation Scripts

Automated setup scripts for system configuration:

```
postinstall/
├── main.sh              # Master orchestration script
└── scripts/
    ├── 00-vars.sh       # Variable definitions
    ├── 01-zsh.sh        # Zsh installation and configuration
    ├── 02-flatpak.sh    # Flatpak setup
    ├── 03-font.sh       # Font installation
    ├── 04-theme.sh      # Theme configuration
    ├── 05-git.sh        # Git setup
    ├── 06-eza.sh        # eza (ls replacement) setup
    ├── 07-gnome.sh      # GNOME settings
    └── 08-toolbox.sh    # Toolbox initialization
```

## 🚀 Quick Start

### Initial Setup

```bash
# Clone this repository
git clone <repo-url> ~/.local/dot-files
cd ~/.local/dot-files

# Run post-installation setup
./postinstall/main.sh
```

### Create Your First Toolbox

```bash
# Create a Python development environment
tbx-create python

# Enter the toolbox
toolbox enter python

# You now have an isolated environment with:
# - Starship prompt
# - Neovim with config
# - Mise for version management
# - Oh My Zsh with plugins
# - Tmux with custom config
```

### Example Workflows

**Machine Learning Development:**

```bash
tbx-create ml-dev
toolbox enter ml-dev
# Install ML packages: pip install tensorflow pytorch scikit-learn
# All configs isolated in ~/.toolbox-envs/ml-dev/
```

**Node.js Development:**

```bash
tbx-create nodejs
toolbox enter nodejs
# Mise auto-manages Node versions from .tool-versions
mise install node@20
mise use node@20
pnpm create react-app my-app
```

**Golang Development:**

```bash
tbx-create golang
toolbox enter golang
# GOPATH, GOCACHE isolated in ~/.toolbox-envs/golang/
go get github.com/user/repo
```

## 🔐 Data Isolation & Persistence

Each toolbox environment maintains complete isolation:

| Directory | Purpose                      | Isolation                       |
| --------- | ---------------------------- | ------------------------------- |
| `config/` | Application configs          | Per-environment copies          |
| `data/`   | Downloaded packages, modules | Per-environment ($GOPATH, etc.) |
| `state/`  | Shell history, session files | Per-environment                 |
| `cache/`  | Build caches, tmp files      | Per-environment                 |

**Host Access:**

Files in each environment persist in `~/.toolbox-envs/<name>/`. To access files from the host:

```bash
# From host, access a toolbox's files
ls ~/.toolbox-envs/python/data/

# From toolbox, access host files
# /root (toolbox home) is separate from host $HOME
# Use /var/mnt/host/ or toolbox file sharing
```

## 📖 Configuration Files

### GNOME Settings (`gnome/`)

Stores GNOME-specific customizations via dconf.

### Container Configuration (`config/`)

Pre-configured tool settings installed by default:

- **nvim/**: Neovim init.lua and plugins
- **starship.toml**: Prompt theming
- **tmux/**: Tmux keybindings and theme

## 🐛 Troubleshooting

**Global variables not set:**

```bash
# If tbx-create/tbx-remove fail, ensure these are set in ~/.zshrc:
export TOOLBOX_ENVS_FOLDER="$HOME/.toolbox-envs"
export TOOLBOX_TEMPLATE_FOLDER="$TOOLBOX_ENVS_FOLDER/_template"
```

**Can't create/remove from inside container:**

```bash
# Exit the container first
exit
# Then run commands on host
tbx-create <name>
```

**Configuration not loading:**

```bash
# Verify template exists
ls ~/.toolbox-envs/_template/

# Reload zsh config
zsh-reload
```

**Cleanup after failed creation:**

```bash
# Manual cleanup if rollback failed
toolbox rm --force <name>        # Remove container
podman rmi toolbox-<name>        # Remove image
rm -rf ~/.toolbox-envs/<name>    # Remove config/data
```

## 📝 License

[Add your license information here]

## 🤝 Contributing

Contributions welcome! Please ensure:

- Changes don't break existing toolbox workflows
- Template modifications are backward compatible
- Shell functions handle edge cases gracefully
