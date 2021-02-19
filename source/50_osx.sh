# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
PATH="/usr/local/bin:$(path_remove /usr/local/bin)"
export PATH

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

#Brew
alias service="brew services"
alias services="brew services"

#Apple Plists
alias unloadAPSD="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.apsd.plist"
alias loadAPSD="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.apsd.plist"

# Make 'less' more.
[[ "$(type -P lesspipe.sh)" ]] && eval "$(lesspipe.sh)"

# Start ScreenSaver. This will lock the screen if locking is enabled.
alias sss="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
