# nix-toolkit
A few simple tools to make life with \*nix a little easier, with a strong emphasis on DevOps/admin usability.

## Pre-reqs ##
* [sshrc](https://github.com/Russell91/sshrc)
* git
* wget (optional - `alias wget='wget -c'` allows resuming downloads)
* python (optional - for now, just used to pretty print json using `json jsonfile.json`)

## Installation ##
* Clone this repo in your home directory
```
cd ~ && git clone https://github.com/gnegri/nix-toolkit.git
```
* Start using the new `.bashrc`:
```
source ~/.bashrc
```
* Prep `.vimrc` for your next ssh session:
```
reload_vimrc
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

Otherwise, peruse .bashrc for aliases provided.

## Troubleshooting/Contributing ##
$USER_DIR_PREFIX and $ROOT_DIR_PREFIX:
* No specific settings for msys, cygwin, solaris etc
