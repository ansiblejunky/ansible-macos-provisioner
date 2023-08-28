#!/bin/zsh

echo -e "List system and application updates"
softwareupdate -l

# XCODE INSTALLATION
echo -e "Verify Xcode command line tools installation"
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
echo -e "List all available xcode command line tools:\n\n"
ls /Library/Developer/CommandLineTools/usr/bin

exit 0
