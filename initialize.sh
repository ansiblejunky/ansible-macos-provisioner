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
if [[ "$OSXP_PYENV_VERSIOPN" == "ansible" ]]
then
    echo -e "Found ansible virtual environment: " $OSXP_PYENV_VERSION
else
    echo -e "pyevn was not initialized ... attempting installation\n"
    pyenv install -s 3.8.2
    pyenv local 3.8.2
    pyenv virtualenv ansible
    pyenv activate ansible
    pip install ansible
fi
echo ""

cp files/.bash_profile ~/.bash_profile
source ~/.bash_profile

echo ""
echo "Success"
exit 0
