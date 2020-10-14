if [[ $1 == 'tohome' ]]; then
    echo "copy file to home directory"
    cp -f ~/.vimrc .vimrc
    cp -f ~/.gitconfig .gitconfig
elif [[ $1 == 'togit' ]]; then
    echo "copy files from home directory"
    cp -f ~/.vimrc .vimrc
    cp -f ~/.gitconfig .gitconfig
else
    echo "Command not support, input following command"
    echo "./update.sh [tohome|togit]"
fi
