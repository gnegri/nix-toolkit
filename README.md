# nix-toolkit
A few simple tools to make life with \*nix a little easier, with a strong emphasis on DevOps/admin usability.

## Pre-reqs ##
* [sshrc](https://github.com/Russell91/sshrc)
* git
* vim
* bc
* tmux (optional)
* wget (optional - `alias wget='wget -c'` allows resuming downloads)
* python (optional - for now, just used to pretty print json using `json_print jsonfile.json`)

## Installation ##
* Install prereqs per your package manager.
* Run the following one-liner to backup your old config files and start using the ones provided here.
```
bash <(curl -s https://raw.githubusercontent.com/gnegri/nix-toolkit/master/install-nix-toolkit.sh)
```

To uninstall, run
```
bash <(curl -s https://raw.githubusercontent.com/gnegri/nix-toolkit/master/uninstall-nix-toolkit.sh)
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

Once ssh'd into your server, you can use 
```
surc
```
to enter a root shell and still use the same bashrc.

Similarly,
```
tmuxrc
```
will open a tmux shell and still use the same bashrc.

You can add whatever settings you like to `.bashrc.secret` (which will come with you) and `.bashrc.local.secret` (which will only affect your local `.bashrc`).

Local `.bashrc` is contructed from:
* `.bashrc.base`
* `.bashrc.shared`
* `.bashrc.secret`
* `.bashrc.local`
* `.bashrc.local.secret`

The `.bashrc` that's used on the target server is constructed from:
* `.sshrc.base`
* `.bashrc.base`
* `.bashrc.shared`
* `.bashrc.secret`

There are also 2 scripts to interact with Git, which are aliased.
```
gitpull [-z] # gitpullz is aliased to pass -z
gitpush [-z] "commit msg" file1 file2 # gitpushz is aliased to pass -z
```

These can be called from any git project folder to push/pull as indicated. The -z flag will make the script set the repo to invisible. Once invisible, you do not need to pass the -z flag going forward. If you want to make the repo visible again, manually do so:
```
mv .git.bck .git
# or
showrepo
```

To hide it again:
```
mv .git .git.bck
# or
hiderepo
```

Otherwise, peruse .bashrc and .vimrc for aliases and keybinds provided respectively.

## Troubleshooting/Contributing ##
* No specific settings for msys, cygwin, solaris etc

## License ##
Just be cool. Don't sell it for profit. Barely anything in here is original code or ideas, anyway. All credit to the fine folks who actually answer things on StackExchange.
