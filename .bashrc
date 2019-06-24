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
#        USER_DIR_PREFIX=
#        ROOT_DIR_PREFIX=
#        ;;
#    msys*)
#        TODO: define these
#        USER_DIR_PREFIX=
#        ROOT_DIR_PREFIX=
#        ;;
#    cygwin*)
#        TODO: define these
#        USER_DIR_PREFIX=
#        ROOT_DIR_PREFIX=
#        ;;
    *) 
        # Others
        USER_DIR_PREFIX="/home"
        ROOT_DIR_PREFIX=""
        ;;
esac

# Set a few directory locales
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

#######
# PS1 #
#######

# configure right-justified timestamp
function r_print() { printf "%*s\r" $1 $2; }

# Set up the git portion of PS1
function PS1_GIT() {
    if [[ ! -z "$GIT_REPO" ]];
    then # in a git repo
        echo $GIT_REPO$GIT_BRANCH
    fi
}

# actual PS1 build
function BUILD_PS1() {
    PS1_DEFAULT_COLOR_CODE='0' # black

    # Right-hand justified time
    PS1_RHJ_COLOR_CODE='37' # gray
    PS1_RHJ='\[\e[s\e['$PS1_RHJ_COLOR_CODE'm$(r_print `echo $(tput cols) - 1 | bc` "["\t"]")\e['$PS1_DEFAULT_COLOR_CODE'm\e[u\]'

    # Basic prompt
    PS1_BASE='[\u@\h \W]'

    # Git
    PS1_GIT_COLOR_CODE='35' # purple
    GIT_REPO='$(basename -s .git `git config --get remote.origin.url 2>/dev/null` 2>/dev/null | sed -n "s/\(.*\)/\ \<\1\//p")'
    GIT_BRANCH='$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1\>/p")'
    PS1_GIT_STANZA='\[\e['$PS1_GIT_COLOR_CODE'm'`PS1_GIT`'\e['$PS1_DEFAULT_COLOR_CODE'm\]'

    # Final prompt char ($ or # if root)
    PS1_PROMPT=' \[\e[1m\]$PROMPT_CHAR\[\e[0m\]'
    
    echo ${PS1_RHJ}${PS1_BASE}${PS1_GIT_STANZA}${PS1_PROMPT}" "
}
PS1=`BUILD_PS1`

# sshrc
VIMINIT="\"let \\\$MYVIMRC='\$SSHHOME/.sshrc.d/.vimrc' | source \\\$MYVIMRC\""
alias sudo='sudo '
alias bashrc='vim ~/.bashrc; reload_bashrc'
function reload_bashrc() {
    source ~/.bashrc
    sudo cp ~/.bashrc $OTHER_DIR/.bashrc
    # set up for user
    sudo cp ~/.bashrc $HOME_DIR/.sshrc 
    echo export VIMINIT=$VIMINIT | sudo tee -a $HOME_DIR/.sshrc >/dev/null
    # set up for root
    sudo cp ~/.bashrc $ROOT_DIR/.sshrc
    echo export VIMINIT=$VIMINIT | sudo tee -a $ROOT_DIR/.sshrc >/dev/null
    echo Bash config reloaded
}
alias vimrc='vim ~/.vimrc; reload_vimrc'
function reload_vimrc() {
    sudo cp ~/.vimrc $OTHER_DIR/.vimrc
    # set up for user
    sudo mkdir -p $HOME_DIR/.sshrc.d
    sudo cp ~/.vimrc $HOME_DIR/.sshrc.d/.vimrc
    # set up for root
    sudo mkdir -p $ROOT_DIR/.sshrc.d
    sudo cp ~/.vimrc $ROOT_DIR/.sshrc.d/.vimrc
    echo Updated vim config
}

alias gitpush=$HOME_DIR'/push-git-repo.sh'
alias gitpushz=$HOME_DIR'/push-git-repo.sh -z'
alias gitpull=$HOME_DIR'/update-git-repo.sh'
alias gitpullz=$HOME_DIR'/update-git-repo.sh -z'

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
alias v=vim
alias vi=vim
alias h='history | grep'
alias j='jobs -l '
alias clr='clear; ls; pwd'
alias x=exit
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
alias tailf='tail -f'

# functions
function json_print() {
    cat "$1" | python -m json.tool
}
