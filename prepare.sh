#! /bin/bash

#install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#install XCode command line tools
xcode-select --install

#install CMake
brew install cmake

#On Mac OS X > 10.10, execute command
brew link openssl --force

#install Fortran
brew install gcc



