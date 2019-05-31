#!/bin/bash

# python virtualenvwrapper wrapper
# Install the dependancies for virtual env wrapper locally as opposed to system wide...
# Inspired by Amazon's packaging standards, a box in a box
# https://virtualenvwrapper.readthedocs.io/en/latest/

# Lets check we actually have pip installed - it uses system python
if ! [ -x "$(command -v pip)" ]; then 
  echo "Python pip isn't installed."
  echo "See https://packaging.python.org/tutorials/installing-packages"
  exit 1
fi

echo "Installing virtualenvwrapper"
pip install --user virtualenvwrapper > /dev/null

# Set $ENV
echo "Setting required environment variables"
export WORKON_HOME=$HOME/.virtualenvs
source $HOME/.local/bin/virtualenvwrapper.sh
echo "Installed and ready to roll"
