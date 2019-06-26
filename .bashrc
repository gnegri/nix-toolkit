alias sudo='sudo '
# OS-specific implementation
# https://stackoverflow.com/a/18434831
case "$OSTYPE" in
    linux*|bsd*) # Linux/BSD
        ROOT_DIR_PREFIX=""
        alias l='\ls --color=auto '
        alias ls='ls -lh --color=auto '
        ;;
    darwin*) # Mac OSX
        ROOT_DIR_PREFIX="/var"
        alias l='\ls -G '
        alias ls='ls -lh -G '
        ;;
#    solaris*) # Solaris
#        TODO: define these
#        ROOT_DIR_PREFIX=
#        ;;
#    msys*) # what is this?
#        TODO: define these
#        ROOT_DIR_PREFIX=
#        ;;
#    cygwin*) # Cygwin
#        TODO: define these
#        ROOT_DIR_PREFIX=
#        ;;
    *)  # Others
        ROOT_DIR_PREFIX=""
        alias l='\ls --color=auto '
        alias ls='ls --color=auto '
        ;;
esac

# Set a few directory locales
ROOT_DIR=$ROOT_DIR_PREFIX'/root'
if [ $(id -u) -eq 0 ];
then # you are root
    IS_ROOT='true'
    PROMPT_CHAR='#'
else # non-root
    IS_ROOT='false'
    PROMPT_CHAR='$'
fi

#######
# PS1 #
#######

# configure right-justified timestamp
# https://superuser.com/questions/187455/right-align-part-of-prompt
function r_print() { printf "%*s\r" $1 $2; }

# Set up the git portion of PS1
function PS1_GIT() {
    # https://stackoverflow.com/a/42543006
    GIT_REPO='$(basename -s .git `git config --get remote.origin.url 2>/dev/null` 2>/dev/null | sed -n "s/\(.*\)/\ \<\1\//p")'
    # https://stackoverflow.com/questions/6245570/how-to-get-the-current-branch-name-in-git
    # lots of options.
    GIT_BRANCH='$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1\>/p")'
    if [[ ! -z "$GIT_REPO" ]];
    then # in a git repo
        echo $GIT_REPO$GIT_BRANCH
    fi
}

# actual PS1 build
function BUILD_PS1() {
    PS1_DEFAULT_CODE='0' # black

    # Right-hand justified time
    # https://superuser.com/questions/187455/right-align-part-of-prompt
    PS1_RHS_COLOR_CODE='37' # gray
    PS1_RHS='\[\e[s\e['$PS1_RHS_COLOR_CODE'm$(r_print `echo $(tput cols) - 1 | bc` "["\t"]")\e['$PS1_DEFAULT_CODE'm\e[u\]'

    # Basic prompt
    PS1_BASE='[\u@\h \W]'

    # Git
    PS1_GIT_COLOR_CODE='35' # purple
    PS1_GIT_STANZA='\[\e['$PS1_GIT_COLOR_CODE'm'`PS1_GIT`'\e['$PS1_DEFAULT_CODE'm\]'

    # Final prompt char ($ or # if root)
    PS1_BOLD_CODE='1'
    PS1_PROMPT=' \[\e['$PS1_BOLD_CODE'm\]$PROMPT_CHAR\[\e['$PS1_DEFAULT_CODE'm\]'
    
    echo ${PS1_RHS}${PS1_BASE}${PS1_GIT_STANZA}${PS1_PROMPT}" "
}
PS1=`BUILD_PS1`

# functions that root shouldn't run
if [[ $IS_ROOT = 'false' ]];
then
    # sshrc
    alias bashrc='vim ~/.bashrc; reload_bashrc'
    function reload_bashrc() {
        cat ~/.bashrc.local >> ~/.bashrc
        source ~/.bashrc
        sudo cp ~/.bashrc $ROOT_DIR/.bashrc
        # set up for user
        cp ~/.sshrc.base ~/.sshrc
        cat ~/.bashrc >> ~/.sshrc 
        # set up for root
        sudo cp ~/.sshrc.base $ROOT_DIR/.sshrc
        sudo bash -c 'cat ~/.bashrc >> $ROOT_DIR/.sshrc'
        echo Bash config reloaded
    }

    alias vimrc='vim ~/.vimrc; reload_vimrc'
    function reload_vimrc() {
        sudo cp ~/.vimrc $ROOT_DIR/.vimrc
        # set up for user
        mkdir -p ~/.sshrc.d
        cp ~/.vimrc ~/.sshrc.d/.vimrc
        # set up for root
        sudo mkdir -p $ROOT_DIR/.sshrc.d
        sudo cp ~/.vimrc $ROOT_DIR/.sshrc.d/.vimrc
        echo Updated vim config
    }
fi

###
# General Aliases
# Mostly gathered from various sources
###

# git
alias gitpush='~/push-git-repo.sh -m'
alias gitpushz='~/push-git-repo.sh -z -m'
alias gitpull='~/update-git-repo.sh'
alias gitpullz='~/update-git-repo.sh -z'
alias hiderepo='mv .git .git.bck'
alias showrepo='mv .git.bck .git'

# diff
alias diff='colordiff '

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# cd
alias cd-='cd -'
alias -- -='cd -'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

# ls
alias ll='ls -rt '
alias la='ls -a '
alias lx='ls -art '
alias ld='ls -d */ '

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
