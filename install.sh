#!/bin/bash
apt update && apt upgrade

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
    local pkgs='git curl wget ripgrep neovim build-essential'
    apt install $pkgs

    # backup old nvim config if exist
    local DIR=~/.config/nvim
	[[ -d $DIR ]] && rm -rf ${DIR}.bak
    [[ -d $DIR ]] && mv $DIR ${DIR}.bak
    mkdir -p $DIR && cp -rf {.*,*} ${DIR}/

    # git clone https://github.com/nyebat/nvim-termux $DIR
}

packages
setup_nvim

