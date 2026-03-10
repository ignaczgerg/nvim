#!/bin/bash
  set -e

  PREFIX="$HOME/.local"
  mkdir -p "$PREFIX/bin"

  # --- Detect OS ---
  if [[ "$OSTYPE" == darwin* ]]; then
      # macOS: use brew
      command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      brew install neovim node python3 ripgrep fd
  else
      # Linux without sudo: install to ~/.local
      # Neovim appimage (no sudo needed)
      curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-appimage
      chmod u+x nvim-appimage
      ./nvim-appimage --appimage-extract
      mv squashfs-root "$PREFIX/nvim-squashfs"
      ln -sf "$PREFIX/nvim-squashfs/usr/bin/nvim" "$PREFIX/bin/nvim"
      rm nvim-appimage

      # Node.js via nvm (no sudo needed, needed for pyright LSP)
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
      nvm install --lts

      # Python (likely already on the cluster, but pip install for user)
      # pip install --user pynvim  # if needed
  fi

  # --- Clone nvim config ---
  if [ ! -d "$HOME/.config/nvim" ]; then
      git clone https://github.com/YOU/nvim.git "$HOME/.config/nvim"
  fi

  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
