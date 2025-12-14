# Dot files

A comprehensive collection of configuration files and installation scripts to set up a productive Linux development environment (optimized for Fedora-based systems).

## 🚀 Overview

This repository manages personal configurations for shell, editor, and system tools, ensuring a consistent and powerful workflow. It features a modular installation process, a fully configured Neovim setup, and a dedicated development container via Toolbox.

## ✨ Features

- **Neovim**: A robust, Lua-based configuration using `lazy.nvim` for package management. Includes setups for LSP, DAP, linting, formatting, and AI assistance.
- **Shell**: Zsh configuration enhanced with `Oh My Zsh` and the blazing fast `Starship` prompt.
- **Terminal Multiplexer**: `tmux` configuration for efficient window and session management.
- **Development Environment**: A custom `Toolbox` container definition (Fedora-based) pre-loaded with essential dev tools like `mise`, `docker`, `clang`, and more.
- **System Customization**: Scripts to automate `dnf` and `flatpak` installations, font setup, themes, and GNOME desktop configuration.
- **Peripheral Management**: `Solaar` rules and configuration for Logitech devices.

## 📂 Repository Structure

```text
.
├── bin/            # Custom binary scripts
├── config/         # Configuration files
│   ├── nvim/       # Neovim lua config
│   ├── zsh/        # Zsh configuration and modules
│   ├── tmux/       # Tmux configuration
│   ├── solaar/     # Solaar (Logitech) settings
│   └── starship.toml
├── gnome/          # Gnome desktop settings
├── icons/          # Custom SVG icons
├── postinstall/    # Automated installation scripts
│   ├── main.sh     # Entry point script
│   └── scripts/    # Modular setup scripts (dnf, flatpak, fonts, etc.)
└── toolbox/        # Containerfile for dev environment
```

## 🛠️ Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/yurihbm/dot-files.git ~/.local/dot-files
    ```

2.  **Run the post-install script:**
    The main script handles sudo privileges, logging, and executes modular setup scripts in order.

    ```bash
    cd ~/.local/dot-files/postinstall
    ./main.sh
    ```

    > **Note:** The script will generate a `postinstall.log` file in the same directory. Check this file if any errors occur.

## ⚙️ Manual Configuration

After the installation script completes, a few manual steps are recommended:

- **Solaar (Logitech):**
  - Deviate "Mouse Gestures" and "Smart Shift" buttons on your mouse.
  - Deviate "Emoji", "Mute Microphone", and "Voice Dictation" keys on your keyboard.
- **GNOME Extensions:** Install/Enable the following extensions for the best experience:
  - Blur my Shell
  - Caffeine
  - Hot Edge
  - Lock Keys
  - Solaar extension
  - System Monitor
  - Quick Settings Tweaks
  - GSConnect
- **Shell:** The script will ask if you want to change your default shell to `zsh`. A restart is required to apply this change.

## 📦 Toolbox

To build and enter the development container defined in `toolbox/Containerfile`:

```bash
podman build -t dev-toolbox -f ./toolbox/Containerfile
toolbox create -i dev-toolbox
toolbox enter dev-toolbox
```

_(Adjust commands based on your specific toolbox workflow)_

