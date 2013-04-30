#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# inspiration from http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="aria2 bashrc gitconfig profile screenrc "    # list of files/folders to symlink in homedir

DO_VIM=yes  #do the vim walk?

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
        echo "Removing old Symlink from .$file"i
        rm -f ~/.$file
    fi
      echo "Creating symlink to $file in home directory."
      ln -s $dir/$file ~/.$file
done

# switch to spf13-vim
if [[ $DO_VIM == "yes" ]];then
    # just move all found .vim* files to Backupdir and create vimrc.local link
    for VFILE in $(find ~ -maxdepth 1 -name ".vim*" -type f);do
        echo "Moving $VFILE to Backupdir"
        mv $VFILE $olddir
    done
    # remove symlinks
    for VFILE in $(find ~ -maxdepth 1 -name ".vim*" -type l);do
        echo "remove symlink $VFILE"
        rm -f $VFILE
    done
    # moving directory
    for VFILE in $(find ~ -maxdepth 1 -name ".vim*" -type d);do
        echo "Moving $VFILE to Backupdir"
        mv $VFILE $olddir
    done
    if [[ -f $dir/vimrc.local ]];then
        ln -s $dir/vimrc.local ~/.vimrc.local
    fi
    # test for vim.nox on the System and
    which vim.nox $>/dev/null
    [ $? -eq 1 ] || echo "you _should_ remove vim.nox on your System"
    # just change to homedir and start Installation of spf13-vim3
    cd ~
    curl http://j.mp/spf13-vim3 -L -o - | sh
fi
