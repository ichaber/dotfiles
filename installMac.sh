#!/bin/bash

# Install homebrow only if /opt/homebrew (ARM) doesn't exist
if [[ ! -d "/opt/homebrew/" ]]
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew upgrade
brew install stow tmux neovim mise eza fzf bat zoxide rg fd television lua jq z ncurses worktrunk sesh docker
brew cleanup

mkdir -p ~/.config/tmux/plugins/tpm
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
git clone -b v2.3.0 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

stow .
