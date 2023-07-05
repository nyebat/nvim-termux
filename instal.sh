#!/bin/bash

packages() {
  pkg update && pkg upgrade
  local pkgs=''

  # core
  pkgs+='git curl wget ripgrep fd neovim build-essetial '

  # Rust
  pkgs+='rust rust-analyzer '

  # Lua
  pkgs+='lua54 lua-language-server '

  # C++
  #pkgs+=' clang clangd '

  pkg install "$pkgs"
}

setup_nvim() {
  git clone https://github.com/matobodol/nvim-dotfile

  local DIR=~/.config/nvim/
  ! [[ -d $DIR ]] && mkdir -p ~/.config/nvim
  
  mv nvim-dotfile $DIR
}
