#!/bin/bash

packages() {
  local pkgs=''

  # core
  pkgs+='git curl wget ripgrep fd neovim build-essential '

  # Rust
  pkgs+='rust rust-analyzer '

  # Lua
  pkgs+='lua-language-server '

  # C++
  pkgs+='clang '

  pkg install "$pkgs"
}

setup_nvim() {
  local DIR=~/.config
  [[ -d $DIR/nvim ]] && mv $DIR/nvim $DIR/nvim.bak
  git clone https://github.com/matobodol/nvim-dotfile ~/.config/nvim
}

packages
setup_nvim
