#!/bin/bash

dotfiles_dir="${HOME}/dotfiles/dotfiles/"
backup_dir="${HOME}/.dotfiles.backup"

# Create symlinks only for dotfiles
for dotfile in ${dotfiles_dir}.*
do 
    name_without_path=${dotfile:${#dotfiles_dir}}
    if [ "${name_without_path}" != "." ];
    then
        if [ "${name_without_path}" != ".." ];
        then
            if [ "${name_without_path:${#name_without_path}-4}" != ".swp" ];
            then
                # if there is a symlink, remove it
                if [ -L "$HOME/$name_without_path" ];
                then
                    echo "Removing Symlink $HOME/$name_without_path"
                    rm "$HOME/$name_without_path"
                fi
                # if there is already an dotfile on HOME, move it to .dotfiles.backup folder
                if [ -f "$HOME/$name_without_path" ] || [ -d "$HOME/$name_without_path" ];
                then
                    [[ ! -d "$backup_dir" ]] && mkdir $backup_dir  # If $backup_dir doesn't exist, create it
                    echo "Moving $HOME/$name_without_path to $backup_dir"
                    mv "$HOME/$name_without_path" "$backup_dir"
                fi

                ln -s $dotfile $HOME/ && echo "Created symlink $HOME/${name_without_path} to $dotfile"
	    fi
        fi
    fi
done

# Modify .bashrc to source .bashrc.my

# Check if .bashrc has already been modified
if cat $HOME/.bashrc | grep -q ". ${HOME}/.bashrc.my";
then
    echo $HOME/.bashrc already updated
else
    echo Updating $HOME/.bashrc

    echo "
############################################################################
# My bashrc 
############################################################################

if [ -f ${HOME}/.bashrc.my ]; then
    . ${HOME}/.bashrc.my
else
    echo \"[bashrc]: Not found ${HOME}/.bashrc.my file\"
fi

############################################################################
" >> ${HOME}/.bashrc
fi

