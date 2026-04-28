#zmodload zsh/zprof #Performance test start
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#Allow extended globbing -> https://www.mankier.com/1/zshexpn#Filename_Generation-Globbing_Flags
setopt extended_glob

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
        #Version Control
        git 
        #Tools
        sudo
        extract
        z
        #Cloud/Infra
        docker
        #Lang/Tools
        dotnet
        python
        #Community (should be last)
        zsh-autosuggestions 
        zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/local/mysql/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/opt/homebrew/bin/

#Powerline-Config
source ~/powerlevel10k/powerlevel10k.zsh-theme

#Functions
sshsu() { ssh "$@" -t 'sudo su -';}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### Customizations for plugins
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#939393,bold,underline"

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# END This speeds up pasting w/ autosuggest

#Add television integration
#echo 'eval "$(tv init zsh)"' >> ~/.zshrc

#Worktrunk integration
if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

### Imports of other scripts (. for fallback needs)
[[ ! -f ~/.config/.bash_aliases ]] || source ~/.config/.bash_aliases
[[ ! -f ~/.config/.bash_aliases_machine ]] || source ~/.config/.bash_aliases_machine
[[ ! -f ~/.config/.bash_export ]] || source ~/.config/.bash_export
[[ ! -f ~/.config/.bash_aws_extensions ]] || source ~/.config/.bash_aws_extensions

#zprof #Perfomance test end
