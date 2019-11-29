#!/bin/bash

# remove git
DOTGLOB_SHOPT=`shopt -p | grep dotglob`
shopt -s dotglob
rm -rf ~/.git* ~/README.md
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

# restore old .tmux.conf
if [[ -f ~/.tmux.conf.bck ]];
then
    mv ~/.tmux.conf.bck ~/.tmux.conf
fi

# remove linuxify
if [[ "$OSTYPE" =~ darwin* && -f ~/.linuxify ]];
then
    bash <(curl -sS https://raw.githubusercontent.com/fabiomaia/linuxify/master/.linuxify) uninstall
fi
