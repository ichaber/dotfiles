# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim

if [! -f ~/.vim/bundle/Vundle.vim ]; then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Download/Update Vim plugins.
if [[ "$(type -P vim)" ]]; then
  vim +PluginInstall! +qall
fi
