add_vivado()
{
    while true; do
        read -p "locate the vivado's path: " vivado
        if [[ ( -d "$vivado" ) || ( -f "$vivado" )]]; then
            echo "vivado path setup finish"
            exit
        else
            echo "vivado do not locate in this path, try again"
        fi
    done
}

CS=`whoami`
echo "current user $CS"
echo "require super user to install all package needed"
# TODO this is for ubuntu usage
PACKTOOL=apt
cd /home/$CS
mkdir -p .vim/bundle
mkdir -p .tmux/plugins
# update to make sure the dependencies is update-to-date
sudo $PACKTOOL update
# install the dependencies
sudo $PACKTOOL install cmake build-essential python3-dev
sudo $PACKTOOL install vim git zsh tmux silversearcher-ag
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c "PlugInstall"

while true; do
    read -p "Do you wish to locate the vivado?" yn
    case $yn in
        [Yy]* ) add_vivado;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
