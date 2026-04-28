#!/bin/bash

# Install homebrew only if /opt/homebrew (ARM) doesn't exist
if [[ ! -d "/opt/homebrew/" ]]
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

APPS="stow tmux neovim mise eza fzf bat zoxide rg fd television lua jq z ncurses worktrunk sesh docker"

brew update
brew upgrade

brew list $APPS &>/dev/null
status=$?

if [ $status -eq 0 ]; then
  echo "Nothing to install"
else
  brew install $APPS 
fi

mkdir -p ~/.config/tmux/plugins/tpm
mkdir -p ~/.config/tmux/plugins/catppuccin


if [ ! "$(ls -A ~/.config/tmux/plugins/tpm)" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

if [ ! "$(ls -A ~/.config/tmux/plugins/catppuccin)" ]; then
  git clone --depth 1 -b v2.3.0 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi

#Clone oh-my-zsh plus plugins
ZSH_CUSTOM_DIR=~/.oh-my-zsh
if [ ! -d $ZSH_CUSTOM_DIR ]; then
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git $ZSH_CUSTOM_DIR
else
  echo "Skip cloning oh-my-zsh"
fi

if [ ! -d $ZSH_CUSTOM_DIR/custom/plugins/zsh-autosuggestions ]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM_DIR:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 
else
  echo "Skip cloning zsh-autosuggestions"
fi

if [ ! -d $ZSH_CUSTOM_DIR/custom/plugins/zsh-syntax-highlighting ]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM_DIR:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  echo "Skip cloning zsh-syntax-highlighting"
fi

read -p "Copy .zshenv to set zsh dir (~/.config/zsh) (y/n): " copyenv
if [ "$copyenv" == "y" ]; then
  cp .zshenv ~/.
else
  echo "Skipping .zshenv copy"
fi

stow .
