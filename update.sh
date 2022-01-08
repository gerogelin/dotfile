if [[ $1 == 'tohome' ]]; then
    echo "copy file to home directory"
    cp -f .vimrc ~/.vimrc
    cp -f .gitconfig ~/.gitconfig
    cp -f .ctags ~/.ctags
    cp -f .tmux.conf ~/.tmux.conf
    cp -f .agignore ~/.agignore
    cp -f .zshrc ~/.zshrc
elif [[ $1 == 'togit' ]]; then
    echo "copy files from home directory"
    cp -f ~/.vimrc .vimrc
    cp -f ~/.gitconfig .gitconfig
    cp -f ~/.ctags .ctags
    cp -f ~/.tmux.conf .tmux.conf
    cp -f ~/.agignore .agignore
    cp -f ~/.zshrc .zshrc
else
    echo "Command not support, input following command"
    echo "./update.sh [tohome|togit]"
fi
