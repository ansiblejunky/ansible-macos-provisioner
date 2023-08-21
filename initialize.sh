#!/bin/bash

task () {
    echo -e "\n\n"
    echo "TASK: [$1] ******************************"
}

echo 
echo "OSX Provisioner"
echo "Initialize system with base required software"

task "List system and application updates"
softwareupdate -l

task "Verify Xcode command line tools installation"
AMP_XCODE_OUTPUT=`xcode-select -p`
AMP_XCODE_PATH="/Library/Developer/CommandLineTools"
if [[ $AMP_XCODE_OUTPUT == $AMP_XCODE_PATH ]]
then
    echo -e "Found Xcode: " $AMP_XCODE_OUTPUT
    echo "Found gcc: " `which gcc`
    echo "Found git: " `which git`
else
    echo -e "WARNING: Xcode Command Line Tools not found or needs to be re-installed. Attempting installation...\n"
    xcode-select --install
fi

# list all available xcode command line tools
#ls /Library/Developer/CommandLineTools/usr/bin


# brew installation folders: (/opt/homebrew/bin/brew for Apple Silicon, /usr/local/bin/brew for macOS Intel and /home/linuxbrew/.linuxbrew/bin/brew for Linux)
task "Verify Homebrew installation"
which brew > /dev/null 2>&1
if [ $? -eq 1 ]; then
    echo -e "Brew was not found ... attempting installation\n"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    PATH=$PATH:/opt/homebrew/bin:/usr/local/bin:/home/linuxbrew/.linuxbrew/bin
else
    echo -e "Found homebrew: " `which brew`
fi

task "Perform brew cleanup tasks"
brew cleanup --quiet
brew doctor --quiet

task "Prepare python environment"
#TODO: Check if pyenv is installed and ansible is available (but careful about not upgrading)
brew install --quiet pyenv
brew install --quiet pyenv-virtualenv

AMP_PYENV_VERSION=`pyenv version-name`
if [[ "$AMP_PYENV_VERSION" == "dev" ]]
then
    echo -e "Found ansible virtual environment: " $AMP_PYENV_VERSION
else
    echo -e "`pyenv` was not initialized ... attempting that now\n"
    # Install the latest version of python that is available
    pyenv install --skip-existing $(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
    # Set the python version as the global default
    pyenv global $(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
    # Create virtual environment for our ansible tools
    pyenv virtualenv dev`
    pyenv global dev
    pip install ansible ansible-lint ansible-navigator[ansible-core] ansible-builder
    pip install --upgrade pip
fi

task "Prepare bash environment"
cp data/.bash_profile ~/.bash_profile
chsh -s /bin/bash
source ~/.bash_profile

task "Prepare ssh configuration"
cp data/ssh.config ~/.ssh/config

task "Completed"
exit 0
