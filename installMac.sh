#!/bin/bash

$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)

brew update
brew upgrade
brew install tmux neovim eza fzf bat lua jq z docker
brew cleanup
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

