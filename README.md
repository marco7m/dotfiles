To use the dotfiles, just run:

```bash
sh install.sh
```

It will update the .bashrc file and create symlinks to the dotfiles on your HOME

**TODO**
- Create a uninstall or clear script, that removes all symlinks and restore the dotfiles in backup if it has one.
- Do something when the user already has a dotfile like .tmux.conf in its HOME
- Add option to choose which dotfiles should be used
