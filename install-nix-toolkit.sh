DOTGLOB_OPT=`shopt -p | grep dotglob` # get dotblob option
shopt -s dotglob # set dotfile expansion so mv sees dotfiles
git clone https://github.com/gnegri/nix-toolkit.git && mv nix-toolkit/* ~ && rm -rf nix-toolkit
eval $DOTGLOB_OPT # reset to original
source ~/.bashrc
reload_bashrc
reload_vimrc
hiderepo
