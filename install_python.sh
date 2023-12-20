#!/bin/zsh

# PYTHON INSTALLATION
which pyenv > /dev/null 2>&1
if [ $? -eq 1 ]; then
    brew install --quiet pyenv
    brew install --quiet pyenv-virtualenv
else
    echo -e "pyenv is already installed"
fi

AMP_PYENV_VERSION=`pyenv version-name`
if [[ "$AMP_PYENV_VERSION" == "dev" ]]
then
    echo -e "Found ansible virtual environment: " $AMP_PYENV_VERSION
else
    echo -e "Install the latest version of python that is available using pyenv"
    pyenv install --skip-existing $(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
    # Create virtual environment
    pyenv virtualenv $(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1) dev
    # Set the global default python environment
    pyenv global dev
    pip install --upgrade pip
    pip install ansible ansible-lint ansible-navigator ansible-builder
fi

exit 0
