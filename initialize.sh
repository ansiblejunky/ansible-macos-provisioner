#!/bin/bash

echo "OSX Provisioner"
echo "Initialize system with base required software"


echo "TASK: [Verify Xcode command line tools installation...] ******************"
OSXP_OUTPUT="$(xcode-select -p)"
OSXP_PATH="/Library/Developer/CommandLineTools"
if [[ -d $OSXP_OUTPUT && $OSXP_OUTPUT =~ $OSXP_PATH* ]]
then
    echo -e "Found:" $OSXP_OUTPUT "\n\n"
else
    echo $OSXP_OUTPUT
    echo -e "WARNING: Xcode Command Line Tools are required. Attempting installation...\n"
    xcode-select --install
    exit 1
fi



echo "TASK: [Verify Xcode command line tools installation...] ******************"
echo "Found gcc: " `which gcc`
echo "Found git: " `which git`

# list all available xcode command line tools
#ls /Library/Developer/CommandLineTools/usr/bin
echo ""
#echo "TASK: [Verify pip installation...] ******************"
# python
#python --version
# pip
#sudo easy_install pip


echo "TASK: [Verify Homebrew installation...] ******************"
OSXP_OUTPUT="$(which brew)"
OSXP_PATH="/usr/local/bin/brew"
if [[ "$OSXP_OUTPUT" == "$OSXP_PATH" ]]
then
    echo -e "Found homebrew: " `which brew`
else
    echo -e "Brew was not found ... attempting installation\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
echo ""

#echo "TASK: [Verify Ansible installation...] ******************"
# ansible
#pip install ansible
#pip install --upgrade ansible
# verify 
#brew install ansible


echo "TASK: [Perform brew cleanup tasks ...] ******************"
brew cleanup
brew doctor

echo ""
echo -e "All checks completed. Ready to start provisioning your system.\n\n"
echo ""


echo "TASK: [Begin base provisioning ...] ******************"
brew install pyenv
brew install pyenv-virtualenv

OSXP_PYENV_VERSION="$(pyenv version-name)"
if [[ "$OSXP_PYENV_VERSION" == "ansible" ]]
then
    echo -e "Found ansible virtual environment: " $OSXP_PYENV_VERSION
else
    echo -e "`pyenv` was not initialized ... attempting that now\n"
    # Install the latest version of python that is available
    pyenv install --skip-existing $(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
    # Set the python version as the global default
    pyenv global $(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
    # Create virtual environment for our ansible tools
    pyenv virtualenv ansible
    pyenv global ansible
    pip install ansible
fi
echo ""

# Bash Profile
cp data/.bash_profile ~/.bash_profile
chsh -s /bin/bash
source ~/.bash_profile

# SSH Configuration
cp data/ssh.config ~/.ssh/config

echo ""
echo "Success"
exit 0
