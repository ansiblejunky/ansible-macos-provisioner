#!/bin/zsh

# HOMEBREW INSTALLATION
# https://docs.brew.sh/Installation
# brew installation folders: (/opt/homebrew/bin/brew for Apple Silicon, /usr/local/bin/brew for macOS Intel and /home/linuxbrew/.linuxbrew/bin/brew for Linux)
which brew > /dev/null 2>&1
if [ $? -eq 1 ]; then
    echo -e "Brew was not found, or is not added to the PATH ... perform installation?\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/jwadleig/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo -e "Found homebrew: " `which brew`
fi

brew cleanup --quiet
brew doctor --quiet

exit 0
