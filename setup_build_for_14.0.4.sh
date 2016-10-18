#!/bin/bash
wget http://archive.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jre-headless_8u45-b14-1_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jre_8u45-b14-1_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jdk_8u45-b14-1_amd64.deb
sudo apt-get update
sudo dpkg -i ~/openjdk-8-jre-headless_8u45-b14-1_amd64.deb
sudo dpkg -i ~/openjdk-8-jre_8u45-b14-1_amd64.deb
sudo dpkg -i ~/openjdk-8-jdk_8u45-b14-1_amd64.deb
sudo apt-get -f install
sudo apt-get install phablet-tools git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip schedtool meld lzop maven2 -y
mkdir cm-14.0 && cd cm-14.0
git config --global user.name "Chau Truong Thinh"
git config --global user.email "chautruongthinh@gmail.com"
repo init -u git://github.com/CyanogenMod/android.git -b cm-14.0
cd .repo
git clone https://github.com/chautruongthinh/local_manifests.git -b cm-14.0
cd ..
repo sync -j32

