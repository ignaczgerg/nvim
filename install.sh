#!/bin/bash
  set -e

  PREFIX="$HOME/.local"
  mkdir -p "$PREFIX/bin"

  if [[ "$OSTYPE" == darwin* ]]; then
      command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      brew install neovim node python3 ripgrep fd
  else
      curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-appimage
      chmod u+x nvim-appimage
      ./nvim-appimage --appimage-extract
      mv squashfs-root "$PREFIX/nvim-squashfs"
      ln -sf "$PREFIX/nvim-squashfs/usr/bin/nvim" "$PREFIX/bin/nvim"
      rm nvim-appimage

      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
      nvm install --lts

  fi

  if [ ! -d "$HOME/.config/nvim" ]; then
      git clone https://github.com/YOU/nvim.git "$HOME/.config/nvim"
  fi

  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
