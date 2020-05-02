# HISTORY settings
# -------------------------------------------------------------
# Append history instead of rewriting it
shopt -s histappend
# Allow a larger history file
HISTFILESIZE=1000000
HISTSIZE=1000000
# Ignore lines starting with a space (ignorespace) and ignore duplicate lines (ignoredups)
HISTCONTROL=ignoreboth
# Ignore specific commands that are useless in history
HISTIGNORE='ls:bg:fg:history'
# Record timestamps
HISTTIMEFORMAT='%F %T '
# Force multiline commands into one line for easier reading
shopt -s cmdhist
# Store history immediately into .bash_history file instead of when session terminates
PROMPT_COMMAND='history -a'
# -------------------------------------------------------------

# brew - enable bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# openshift - custom text editor
export OC_EDITOR="code -w"

# homebrew path required
export PATH="/usr/local/sbin:$PATH"

# color settings
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

# chrome
chrome () {
    open -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome "$1"
}

# go - path settings
export GOPATH=$HOME/go

# python environment manager - pyenv and virtualenv auto activation
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


# PROMPT settings
# -------------------------------------------------------------
function updatePrompt {

    # Provide git branch information
    parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }

    # Styles
    GREEN='\[\e[0;32m\]'
    BLUE='\[\e[0;34m\]'
    RESET='\[\e[0m\]'

    # Base prompt: \W = working dir
    PROMPT="[\t] \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\]"

    # Current virtualenv
    if [[ $VIRTUAL_ENV != "" ]]; then
        # Strip out the path and just leave the env name
        PROMPT="$PROMPT ${BLUE}[${VIRTUAL_ENV##*/}]${RESET}"
    fi

    PS1="$PROMPT \$ "
}
export -f updatePrompt
# Bash shell executes this function just before displaying the PS1 variable
export PROMPT_COMMAND='updatePrompt'
# -------------------------------------------------------------
