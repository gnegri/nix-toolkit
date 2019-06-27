#!/bin/bash

# save off old bashrc
if [[ ! -f ~/.bashrc.bck ]];
then
    mv ~/.bashrc ~/.bashrc.bck
fi
# save off old vimrc
if [[ ! -f ~/.vimrc.bck ]];
then
    mv ~/.vimrc ~/.vimrc.bck
fi

# get dotblob option
DOTGLOB_SHOPT=`shopt -p | grep dotglob` 
# set dotfile expansion so mv sees dotfiles
shopt -s dotglob 
# get the repo and move contents to ~
git clone https://github.com/gnegri/nix-toolkit.git && mv nix-toolkit/* ~ && rm -rf nix-toolkit
# reset to original
eval $DOTGLOB_SHOPT 
# hide repo
mv .git .git.bck

# start using new bashrc
touch .bashrc.local
cp ~/.bashrc.shared ~/.bashrc
source ~/.bashrc
# set bashrc for this user
reload_bashrc
# get vimrc ready for sshrc
reload_vimrc

