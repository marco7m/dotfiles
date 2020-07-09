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
                if [[ -L "$HOME/${dotfile:${#dotfiles_dir}}" ]];
                then
                    echo Removing symbolic link $HOME/${dotfile:${#dotfiles_dir}}
                    rm $HOME/${dotfile:${#dotfiles_dir}}
                fi
	    fi
        fi
    fi
done
