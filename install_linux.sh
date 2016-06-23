#!/bin/bash

DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)/linux"
LOGDIR=$(mktemp -dt)
clr_ylw=$(tput setaf 3)
clr_red=$(tput setaf 1)
clr_grn=$(tput setaf 2)
clr_reg=$(tput sgr0)

if [[ `uname` == 'Darwin' ]]; then
    echo "Whoa! I don't want all this Linux shit on my OS X."
    exit 1
fi

if [[ `whoami` == 'root' ]]; then
    echo "Whoa! No roots here, only artems."
    exit 1
fi

echo "Commencing installation, the logs are kept in ${LOGDIR}..."

header ()
{
    echo "$clr_ylw$1$clr_reg"
}

donezo ()
{
    echo "${clr_grn}Done${clr_reg}"
}

################################################################################
header "# Environment settings..."
################################################################################
sudo gpasswd -a artem vboxsf

################################################################################
header "# Installing packages..."
################################################################################

apt_last_updated=$(ls --full-time /var/cache/apt/pkgcache.bin | cut -d' ' -f6)

if [ `date +%F` \> $apt_last_updated ]; then
    sudo apt-get update > $LOGDIR/apt.log
fi
sudo apt-get -y install policykit-1
sudo apt-get -y install xorg build-essential wget unzip tmux slim surf libx11-dev \
    libxft-dev libxinerama-dev feh dkms xclip >> $LOGDIR/apt.log

donezo

################################################################################
header "# Linking all the configs..."
################################################################################

ln -sf $DIR/.bashrc ~/.bashrc
ln -sf $DIR/.asoundrc ~/.asoundrc
ln -sf $DIR/.xinitrc ~/.xinitrc
ln -sf $DIR/.Xresources ~/.Xresources
ln -sf $DIR/.Xresources.hidpi ~/.Xresources.hidpi
ln -sf $DIR/.Xresources.lodpi ~/.Xresources.lodpi
ln -sf $DIR/.auto-dpi.sh ~/.auto-dpi.sh
ln -sf $DIR/.tmux.conf ~/.tmux.conf
ln -sf $DIR/.gtkrc-2.0 ~/

donezo

################################################################################
header "# Linking all scripts..."
################################################################################

mkdir -p ~/bin
ln -sf $DIR/scripts/pbcopy ~/bin/
ln -sf $DIR/scripts/impostor ~/bin/
ln -sf $DIR/scripts/dwmdwmdwm ~/bin/
ln -sf $DIR/scripts/ssh-add-macbook ~/bin/
ln -sf $DIR/../scripts/git-web ~/bin/

################################################################################
header "# Configuring desktop environment..."
################################################################################

mkdir -p ~/projects

cd ~/projects
if [ ! -d dwm ]; then
    git clone git@github.com:temochka/dwm.git >> $LOGDIR/git.log
else
    cd dwm
    git pull $(git remote | head -n1) custom
fi

cd ~/projects
if [ ! -d st ]; then
    git clone git@github.com:temochka/st.git >> $LOGDIR/git.log
else
    cd st
    git pull $(git remote | head -n1) custom
fi

cd ~/projects
if [ ! -d dmenu ]; then
    git clone git@github.com:temochka/dmenu.git >> $LOGDIR/git.log
else
    cd dmenu
    git pull $(git remote | head -n1) custom
fi

cd ~/projects/dwm
make > $LOGDIR/dwm.log
sudo make install >> $LOGDIR/dwm.log

cd ~/projects/st
make > $LOGDIR/st.log
sudo make install >> $LOGDIR/st.log

cd ~/projects/dmenu
make > $LOGDIR/dmenu.log
sudo make install >> $LOGDIR/dmenu.log

sudo cp -r $DIR/slim-theme /usr/share/slim/themes/debian-lines-hidpi
sudo sed -ri 's/^#? ?default_user.*/default_user artem/' /etc/slim.conf
sudo sed -i 's/^current_theme.*/current_theme debian-lines-hidpi/' /etc/slim.conf
sudo sed -i 's/^login_cmd.*/login_cmd exec \/bin\/bash - ~\/.xinitrc %session/' /etc/slim.conf
sudo sed -ri 's/^#? ?auto_login.*/auto_login yes/' /etc/slim.conf

donezo

################################################################################
header "# Installing Fonts..."
################################################################################

fira_target_dir=/usr/share/fonts/truetype/fira/
fontconfig_dir=~/.config/fontconfig.avail

mkdir -p $fontconfig_dir
ln -sf $DIR/hidpi-fonts.conf $fontconfig_dir/
ln -sf $DIR/lodpi-fonts.conf $fontconfig_dir/

sudo apt-get -y install fonts-play fonts-droid fonts-ubuntu-title \
    fonts-ubuntu-font-family-console fonts-opensymbol fonts-liberation \
    ttf-ubuntu-font-family >> $LOGDIR/apt.log


mkdir -p ~/projects
sudo mkdir -p $fira_target_dir
cd ~/projects

if [ ! -d fira ]; then
    wget -nc https://github.com/mozilla/Fira/archive/master.zip
    unzip master.zip
    rm master.zip
    mv Fira-master fira
fi

sudo cp ~/projects/fira/ttf/* $fira_target_dir
sudo fc-cache -fv > $LOGDIR/fontconfig.log

donezo

################################################################################
header "# Configuring Vim..."
################################################################################

sudo apt-get -y install vim > $LOGDIR/apt.log

ln -sf $DIR/.vimrc ~/.vimrc
mkdir -p ~/.vim ~/.vim/bundle ~/.vim/autoload
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.githubusercontent.com/tpope/vim-pathogen/v2.3/autoload/pathogen.vim

cd ~/.vim/bundle

git clone https://github.com/guns/vim-clojure-static > /dev/null 2>&1
git clone https://github.com/altercation/vim-colors-solarized > /dev/null 2>&1
git clone git://github.com/tpope/vim-dispatch.git > /dev/null 2>&1
git clone git://github.com/tpope/vim-fireplace.git > /dev/null 2>&1
git clone git://github.com/tpope/vim-leiningen.git > /dev/null 2>&1
git clone git://github.com/tpope/vim-projectionist.git > /dev/null 2>&1

donezo

################################################################################
header "# Configuring SSH..."
################################################################################

grep "Host macbook" ~/.ssh/config > /dev/null 2>&1 || cat $DIR/.ssh_config >> ~/.ssh/config && chmod 660 ~/.ssh/config

donezo

################################################################################
header "# Configuring Sublime Text..."
################################################################################

st_user_dir="$HOME/.config/sublime-text-3/Packages/User"
mkdir -p $st_user_dir

ln -f "$DIR/extras/Default (Linux).sublime-keymap" "$st_user_dir/Default (Linux).sublime-keymap"
cp -n "$DIR/extras/Preferences.sublime-settings" "$st_user_dir/Preferences.sublime-settings"
ln -sf "$DIR/extras/dpi.py" "$st_user_dir/"

donezo

################################################################################
header "# Configuring Git..."
################################################################################
git config --global user.name "Artem Chistyakov"
git config --global user.email "chistyakov.artem@gmail.com"

donezo
