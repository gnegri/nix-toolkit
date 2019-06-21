# nix-toolkit
A few simple tools to make life with \*nix a little easier, with a strong emphasis on DevOps/admin usability.

## Pre-reqs ##
* git
* [sshrc](https://github.com/Russell91/sshrc)
* wget (optional)
* python (optional)

## Installation ##
* Clone this repo in your home directory
```
cd ~ && git clone https://github.com/gnegri/nix-toolkit.git
```
* In `.bashrc`, edit HOME_DIR and ROOT_DIR variables as appropriate.
* Start using the new `.bashrc`:
```
source ~/.bashrc
```
* Prep `.vimrc` for your next ssh session:
```
vimrc
```

## Usage/Effects ##
PS1 is modified to show 
```
[user@hostname pwd_short] $ 
```

When in a git repo, it will also show the repo and branch name:
```
[user@hostname pwd_short] <repo_name/branch> $ 
```
