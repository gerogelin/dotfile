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
su -
PACKTOOL=apt
cd /home/$CS
mkdir -p .vim/bundle
$PACKTOOL install vim the_silver_searcher silversearcher-ag git zsh

while true; do
    read -p "Do you wish to locate the vivado?" yn
    case $yn in
        [Yy]* ) add_vivado;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
