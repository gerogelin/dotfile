# NOTE this script is only tested on bash instead of other shell
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

if [[ $1 == "pre" || $1 == "all" ]]; then
    CS=`whoami`
    echo "current user $CS"
    echo "require super user to install all package needed"
    # TODO this is for ubuntu usage
    PACKTOOL=apt
    # call file to update
    ./update.sh tohome
    mkdir -p ~/.vim/bundle
    mkdir -p ~/.tmux/plugins
    mkdir -p ~/.ssh/
    cp -f .sshconfig ~/.ssh/config
    ssh-keygen
    # update to make sure the dependencies is update-to-date
    sudo $PACKTOOL update
    # install the dependencies
    sudo $PACKTOOL install cmake build-essential python3-dev
    sudo $PACKTOOL install vim git zsh tmux silversearcher-ag
fi

if [[ $1 == "tmux" || $1 == "all" ]]; then
    # TODO use https instead of the ssh, make sure there are timeout mechanism
    git clone git@github.com:tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [[ $1 == "vim" || $1 == "all" ]]; then
    #curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    git clone git@github.com:junegunn/vim-plug
    cp vim-plug/plug.vim ~/.vim/autoload/plug.vim
    rm -rf vim-plug
    vim -c "PlugInstall"
    # compile the youcompleteme plugin for vim
    cd ~/.vim/bundle/YouCompleteMe
    python3 install.py --clangd-completer
fi

if [[ $1 == "zsh" || $1 == "all" ]]; then
    # setup the zsh
    git clone git@github.com:ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    # cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    chsh -s $(which zsh)
fi

if [[ $1 == "fpga" || $1 == "all" ]]; then
    while true; do
        read -p "Do you wish to locate the vivado?" yn
        case $yn in
            [Yy]* ) add_vivado;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi

if [[ $1 == "disk" || $1 == "all-extend" ]]; then
    ln -s /mnt/c ~/system
    ln -s /mnt/d ~/data
fi

if [[ $1 == "scala" || $1 == "all" ]]; then
    sudo apt-get install default-jdk
    echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
    sudo apt-get update
    sudo apt-get install sbt
    mkdir -p ~/.sbt/
    cp -f .sbtrepo ~/.sbt/repositories
fi

if [[ $1 == "sim" || $1 == "all" ]]; then
    sudo apt-get install pip iverilog
    pip install cocotb
fi
