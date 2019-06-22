# PS1
case "$OSTYPE" in
    linux*|bsd*)
        # Linux/FreeBSD
        USER_DIR_PREFIX="/home"
        ROOT_DIR_PREFIX=""
        ;;
    darwin*)
        # Mac OSX
        USER_DIR_PREFIX="/Users"
        ROOT_DIR_PREFIX="/var"
        ;;
#    solaris*)
#        TODO: define these
#        ;;
#    msys*)
#        TODO: define these
#        ;;
    *) 
        # Others
        USER_DIR_PREFIX="/home"
        ROOT_DIR_PREFIX=""
        ;;
esac

ROOT_DIR=$ROOT_DIR_PREFIX'/root'
HOME_DIR=$USER_DIR_PREFIX'/'`whoami`
if [ $(id -u) -eq 0 ];
then # you are root
    PROMPT_CHAR='#'
    OTHER_DIR=$HOME_DIR
else # non-root
    PROMPT_CHAR='$'
    OTHER_DIR=$ROOT_DIR
fi

REPO_IGNORE='nix-toolkit'
PS1='[\u@\h \W]$(if [ "$(basename -s .git `git config --get remote.origin.url 2>/dev/null` 2>/dev/null)" != "$REPO_IGNORE" ]; then echo "$(basename -s .git `git config --get remote.origin.url 2>/dev/null` 2>/dev/null | sed -n "s/\(.*\)/ \<\1/p")$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\/\1\>/p")"; fi) \[\e[1m\]$PROMPT_CHAR\[\e[0m\] '

# sshrc
VIMINIT="\"let \\\$MYVIMRC='\$SSHHOME/.sshrc.d/.vimrc' | source \\\$MYVIMRC\""
alias sudo='sudo '
alias bashrc='vim ~/.bashrc; reload_bashrc'
reload_bashrc() {
    source ~/.bashrc
    sudo cp ~/.bashrc $OTHER_DIR/.bashrc
    # set up for user
    sudo cp ~/.bashrc $HOME_DIR/.sshrc 
    echo export VIMINIT=$VIMINIT | sudo tee -a $HOME_DIR/.sshrc
    # set up for root
    sudo cp ~/.bashrc $ROOT_DIR/.sshrc
    echo export VIMINIT=$VIMINIT | sudo tee -a $ROOT_DIR/.sshrc
    echo Bash config reloaded
}
alias vimrc='vim ~/.vimrc; reload_vimrc'
reload_vimrc() {
    sudo cp ~/.vimrc $OTHER_DIR/.vimrc
    # set up for user
    sudo mkdir -p $HOME_DIR/.sshrc.d
    sudo cp ~/.vimrc $HOME_DIR/.sshrc.d/.vimrc
    echo ":imap <special> jk <Esc>" | sudo tee -a $HOME_DIR/.sshrc.d/.vimrc
    # set up for root
    sudo mkdir -p $ROOT_DIR/.sshrc.d
    sudo cp ~/.vimrc $ROOT_DIR/.sshrc.d/.vimrc
    echo ":imap <special> jk <Esc>" | sudo tee -a $ROOT_DIR/.sshrc.d/.vimrc
    echo Updated vim config
}

# diff
alias diff='colordiff '

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# cd
alias cd-='cd -'
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

# ls
alias l='ls'
alias ls='ls -lh'
alias ll='ls -rt'
alias la='ls -a'
alias lx='ls -art'

# handy short cuts
alias su='sudo -i'
alias wd='basename `pwd`'
alias v=vim
alias vi=vim
alias h='history | grep'
alias j='jobs -l '
alias clr='clear;ls;pwd'
alias df='df -h'
alias mount='mount | column -t'
alias wget='wget -c'
alias mkdir='mkdir -pv'
alias chownr='chown -R'
alias chmodr='chmod -R'
alias chgrpr='chgrp -R'
alias untar='tar xzvf'
alias targz='tar czvf'
alias sha='shasum -a 256'
alias ping='ping -c 5'
alias ipint='ipconfig getifaddr en0'
alias ipext='curl ipinfo.io/ip'
alias psef='ps -ef | grep'
alias ssh='sudo sshrc'

# functions
json() {
    cat "$1" | python -m json.tool
}

