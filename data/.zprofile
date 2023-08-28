# History Settings
# -------------------------------------------------------------
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
#shopt -s cmdhist
# Store history immediately into .bash_history file instead of when session terminates
#shopt -s histappend
# -------------------------------------------------------------

# Brew Package Manager
# -------------------------------------------------------------
# enable bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
# homebrew path required
export PATH="/usr/local/sbin:$PATH"
# -------------------------------------------------------------


# Browser
# -------------------------------------------------------------
chrome () {
    open -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome "$1"
}
# -------------------------------------------------------------


# Go Environment
# -------------------------------------------------------------
export GOPATH=$HOME/go
# -------------------------------------------------------------

# Python Environments
# -------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
# -------------------------------------------------------------

# Ruby Environments
# -------------------------------------------------------------
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# -------------------------------------------------------------



# Colors and Prompt
# -------------------------------------------------------------
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
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

    # Current python environment
    PYENV_VERSION_NAME=`pyenv version-name`
    # Strip out any paths and just leave the env name
    PROMPT="$PROMPT [${BLUE}${PYENV_VERSION_NAME##*/}${RESET}]"

    PS1="$PROMPT \$ "
}
export -f updatePrompt
# Bash shell executes this function just before displaying the PS1 variable
export PROMPT_COMMAND='updatePrompt'
if [ -n "$PS1" -a -n "$BASH_VERSION" ]; then source ~/.bashrc; fi
# -------------------------------------------------------------


# Red Hat Ansible and OpenShift
# -------------------------------------------------------------
# Enable gnu-sed to handle Ansible Automation Platform installer using sed
# Requires `brew install gnu-sed`
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
# Set default text editor for Red Hat Openshift to use VSCode
export OC_EDITOR="code -w"
# -------------------------------------------------------------



# iTerm
# -------------------------------------------------------------
# Function allows user to set terminal window tab title
function title ()
{
    TITLE=$*;
    export PROMPT_COMMAND='echo -ne "\033]0;$TITLE\007"'
}
# -------------------------------------------------------------
