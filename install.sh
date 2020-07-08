#ln -s $HOME/dotfiles/.bashrc.my $HOME/

dotfiles_dir="${HOME}/dotfiles/dotfiles/"

# Create symlinks only for dotfiles
for dotfile in ${dotfiles_dir}.*
do 
    name_without_path=${dotfile:${#dotfiles_dir}}
    if [[ "${name_without_path}" != "." ]];
    then
        if [[ "${name_without_path}" != ".." ]];
        then
            if [[ "${name_without_path:${#name_without_path}-4}" != ".swp" ]];
            then
                ln -s $dotfile $HOME/ &&
                echo "Created symlink $HOME/${name_without_path}"
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

