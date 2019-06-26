#!/bin/bash

# remove update cron entry
rm -rf /etc/cron.d/update-nix-toolkit

# remove git
DOTGLOB_SHOPT=`shopt -p | grep dotglob`
shopt -s dotglob
rm -rf ~/.git*
eval $DOTGLOB_SHOPT

# restore old bashrc
if [[ -f ~/.bashrc.bck ]];
then
    mv ~/.bashrc.bck ~/.bashrc
fi

# make a bashrc if none exists
if [[ ! -f ~/.bashrc ]];
then
    touch ~/.bashrc
fi

# source the old/blank bashrc
source ~/.bashrc

# restore old vimrc
if [[ -f ~/.vimrc.bck ]];
then
    mv ~/.vimrc.bck ~/.vimrc
fi

