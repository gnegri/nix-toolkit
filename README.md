# nix-toolkit
A few simple tools to make life with \*nix a little easier, with a strong emphasis on DevOps/admin usability.

## Pre-reqs ##
* [sshrc](https://github.com/Russell91/sshrc)
* git
* wget (optional - `alias wget='wget -c'` allows resuming downloads)
* python (optional - for now, just used to pretty print json using `json_print jsonfile.json`)

## Installation ##
* Clone this repo in your home directory or wget it if you don't want to be able to update or contribute
```
cd ~ && git clone https://github.com/gnegri/nix-toolkit.git
# or
wget https://github.com/gnegri/nix-toolkit/archive/master.tar.gz
tar xzvf master.tar.gz --strip 1 -C ~
rm master.tar.gz
# you can later manually update by using wget on the raw versions of files
```
* Start using the new `.bashrc`:
```
source ~/.bashrc
```
* Prep `.vimrc` for your next ssh session:
```
reload_vimrc
```
* Set the repo to invisible so `<nix-toolkit/master>` isn't always appended when you're in `~`, but not a different repo:
```
mv ~/.git ~/.git.bck
# or
cd ~ && gitpull -z
```

## Usage/Effects ##
PS1 is modified to show 
```
[user@hostname pwd_short] $                                       [HH:MM:SS]
```

When in a git repo, it will also show the repo and branch name:
```
[user@hostname pwd_short] <repo_name/branch> $                    [HH:MM:SS] 
```

There are also 2 scripts to interact with Git, which are aliased.
```
gitpull [-z] # gitpullz is aliased to pass -z
gitpush [-z] -m "commit msg" file1 file2 # gitpushz is aliased to pass -z
```

These can be called from any git project folder to push/pull as indicated. The -z flag will make the script set the repo to invisible. Once invisible, you do not need to pass the -z flag going forward. If you want to make the repo visible again, manually do so:
```
mv .git.bck .git
```

Otherwise, peruse .bashrc and .vimrc for aliases and keybinds provided respectively.

## Troubleshooting/Contributing ##
$USER_DIR_PREFIX and $ROOT_DIR_PREFIX:
* No specific settings for msys, cygwin, solaris etc
