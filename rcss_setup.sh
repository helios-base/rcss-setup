#! /bin/bash -f

##############################################################################
# rcss_setup.sh
# instal the following softwares
#  * rcssserver-18.1.3
#  * rcssmonitor-18.0.0
#  * librcsc (rc2023 edition)
#  * soccerwindow2 (rc2023 edition)
#  * helios-base (support-v18 edition)
#
# Copyright (c) July 2023 Tomoharu Nakashima
# All rights reserved.
# MIT Lisence
##############################################################################


##########################
# Preparation
##########################
#set -x
para=6


#############################
# Make the ubuntu up to date
#############################
sudo apt update -y
sudo apt upgrade -y

##########################
# Directory plan
##########################
# .
# └── rc
#     ├── teams
#     │   └── base_teams
#     │       └── helios-base-support-v18
#     └── tools
#         ├── bin
#         ├── include
#         ├── lib
#         ├── librcsc-rc2023
#         ├── rcssmonitor-18.0.0
#         ├── rcssserver-18.1.3
#         ├── share
#         └── soccerwindow2-rc2023



mkdir rc
cd rc
mkdir tools
cd tools

#######################
# install rcssserver
#######################
sudo apt install build-essential automake autoconf libtool flex bison libboost-all-dev
curl -LOk https://github.com/rcsoccersim/rcssserver/releases/download/rcssserver-18.1.3/rcssserver-18.1.3.tar.gz
tar xvzf rcssserver-18.1.3.tar.gz
cd rcssserver-18.1.3
./configure --prefix=$HOME/rc/tools
make -j2
make install
echo '' >> ~/.bashrc
echo '' >> ~/.bashrc
echo '# added by rcss_setup.sh' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$HOME/rc/tools/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export PATH=$HOME/rc/tools/bin:$PATH' >> ~/.bashrc
cd

#######################
# install rcssmonitor
#######################
sudo apt install build-essential qtbase5-dev qt5-qmake libfontconfig1-dev libaudio-dev libxt-dev libglib2.0-dev libxi-dev libxrender-dev
cd rc/tools
curl -LOk https://github.com/rcsoccersim/rcssmonitor/releases/download/rcssmonitor-18.0.0/rcssmonitor-18.0.0.tar.gz
tar xvzf rcssmonitor-18.0.0.tar.gz
cd rcssmonitor-18.0.0
./configure --prefix=$HOME/rc/tools
make -j2
make install
cd


#######################
# install librcsc
#######################
sudo apt install build-essential libboost-all-dev autoconf automake libtool
cd rc/tools
curl -LOk https://github.com/helios-base/librcsc/archive/refs/tags/rc2023.tar.gz
tar xvzf rc2023.tar.gz
cd librcsc-rc2023
./bootstrap
./configure --prefix=$HOME/rc/tools
make -j2
make install
cd


#######################
# install soccerwindow2
#######################
sudo apt install build-essential automake autoconf libtool libboost-all-dev qtbase5-dev qt5-qmake libfontconfig1-dev libaudio-dev libxt-dev libglib2.0-dev libxi-dev libxrender-dev
cd rc/tools
curl -LOk https://github.com/helios-base/soccerwindow2/archive/refs/tags/rc2023.tar.gz
tar xvzf rc2023.tar.gz
cd soccerwindow2-rc2023
./bootstrap
./configure --prefix=$HOME/rc/tools --with-librcsc=$HOME/rc/tools
make -j2
make install
echo 'export RCSSMONITOR=sswindow2' >> ~/.bashrc
echo '' >> ~/.bashrc
cd


#######################
# install helios-base
#######################
sudo apt install build-essential libboost-all-dev
cd rc
mkdir teams
cd teams
mkdir base_teams
cd base_teams
curl -LOk https://github.com/helios-base/helios-base/archive/refs/tags/support-v18.tar.gz
tar xvzf support-v18.tar.gz
cd helios-base-support-v18
./bootstrap
./configure --with-librcsc=$HOME/rc/tools
make -j2


#######################
# End message
#######################
echo ''
echo '### Installation finished ###'
echo -e "Setup is finished. Please type 'source "\~\/".bashrc' "

