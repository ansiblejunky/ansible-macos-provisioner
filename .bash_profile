# Color directory listing
export CLICOLOR=1

# auto completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# homebrew path required
#export PATH="/usr/local/sbin:$PATH"

# ruby and jekyll - installed by homebrew
# if you updated ruby to a version with different
# first 2 digits then update these statements
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH

# python environment manager - pyenv and virtualenv auto activation
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

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

    # Current Git repo
    # if type "__git_ps1" > /dev/null 2>&1; then
    #     PROMPT="$PROMPT$(__git_ps1 "${GREEN}(%s)${RESET}")"
    # fi

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
