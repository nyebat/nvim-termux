#!/bin/bash
apt update && apt upgrade -y

packages() {
    local pkgs=''

    # Rust
    pkgs+='rust rust-analyzer '

    # Lua
    pkgs+='lua-language-server '

    # C++
    pkgs+='clang '

    apt install $pkgs
}

setup_nvim() {
    # core
    local pkgs='git curl wget ripgrep neovim build-essetial'
    apt install "$pkgs"

    # backup old nvim config if exist
    local DIR=~/.config/nvim
    [[ -d $DIR ]] && mv $DIR ${DIR}.bak
    mkdir $DIR && cp -r {.*,*} ${DIR}/

    # git clone https://github.com/nyebat/nvim-termux $DIR
}

packages
setup_nvim

