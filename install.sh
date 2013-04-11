#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# inspiration from http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="aria2 bashrc gitconfig profile screenrc vim vimrc.before vimrc.after"    # list of files/folders to symlink in homedir

DO_VIM=yes  #If you want that janus is setup on your system

##########

# create dotfiles_old in homedir
if [[ ! -d $olddir ]];then
  echo "Creating $olddir for backup of any existing dotfiles in ~"
  mkdir -p $olddir
  echo "...done"
fi

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
      if [[ -f ~/.$file ]];then
        echo "Moving '.$file' from ~ to $olddir"
        mv ~/.$file $olddir/
      fi
      if [[ -h ~/.$file ]];then
        echo "Removing old Symlink from .$file"
        rm -f ~/.$file
      fi
      echo "Creating symlink to $file in home directory."
      ln -s $dir/$file ~/.$file
done

# we want to setup janus!
if [[ $DO_VIM == "yes" ]];then
  cd $dir/vim
  rake
fi
