# visudo
sudo timedatectl set-timezone Europe/Dublin
# ps -ef | grep yum  .... kill -9

require ~/jab/src/bash/hub.sh
require ~/jab/src/bash/github.sh

install_git () {
    sudo yum -y groupinstall "Development Tools"
    sudo yum -y install gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel curl-devel
    # For latest release see $GITHUB/git/git/releases
    GIT_VERSION=2.6.0
    wget $GITHUB/git/git/archive/v${GIT_VERSION}.tar.gz
    tar xvf v${GIT_VERSION}.tar.gz
    cd git-${GIT_VERSION}
    make configure
    ./configure --prefix=/usr/local
    sudo make install
}

install_git

sudo rm -rf ~/Downloads/*

# Install dotjab

cd ~/hub

# If you are reading this then dotjab ($GITHUB/jalanb/jab) is already cloned
git clone $GITHUB/jalanb/pysyte
git clone $GITHUB/jalanb/whyp
git clone $GITHUB/jalanb/cde
git clone $GITHUB/jalanb/ackvim
pip install git+https://github.com/jeffkaufman/icdiff.git

cd ~/jab
cd server/linux
bash make_software.sh

# set up python
pip install pysyte


# set up CentOS
cd ~/jab/server/linux/centos
bash install_software.sh


# set up Gnome
cd ../gnome
bash make_vim_default_editor.sh
cd ~/jab
test -d local || mkdir local
cd local


# set up JAb

cd ~/jab/server/jab
bash clean_directories.sh
bash home/.link
