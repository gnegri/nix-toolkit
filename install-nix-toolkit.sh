#!/usr/bin/env bash
cd ~

# save off old bashrc
if [[ ! -f ~/.bashrc.bck ]];
then
    # put current bashrc in a local unsynced file
    cp ~/.bashrc ~/.bashrc.local.secret
    mv ~/.bashrc ~/.bashrc.bck
fi
# save off old vimrc
if [[ ! -f ~/.vimrc.bck ]];
then
    mv ~/.vimrc ~/.vimrc.bck
fi
# save off old tmux.conf
if [[ ! -f ~/.tmux.conf ]];
then
    mv ~/.tmux.conf ~/.tmux.conf.bck
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

# get linuxify
if [[ "$OSTYPE" =~ darwin* ]];
then
    curl -sS https://raw.githubusercontent.com/fabiomaia/linuxify/master/.linuxify > ~/.linuxify
    bash <(curl -sS https://raw.githubusercontent.com/fabiomaia/linuxify/master/linuxify) install
fi

# start using new bashrc
touch .bashrc.secret
cp ~/.bashrc.shared ~/.bashrc
source ~/.bashrc
# set bashrc for this user
reload_bashrc
# get vimrc ready for sshrc
reload_vimrc
# get tmux.conf ready for sshrc
reload_tmux
