#!/bin/bash
set -e

myname="$0"

function help() {
    cat <<EOF
Syntax:
  $myname <rom type> <branch>

ROM types:
  lineage (Lineage OS)
  rr (Resurrection Remix OS)
  cdroid (crDroid Rom)
  dotOS (Droidontime)

Branchs of roms:
* lineage (LineageOS):
  * cm-14.1
  * lineage-15.0
  * lineage-15.1
  * lineage-16.0

* rr (ResurrectionRemix):
  * marshmallow
  * nougat
  * oreo
  * pie

* cdroid (crDroid Rom)
  * 7.0
  * 7.1
  * 8.0
  * 8.1
  * 9.0

* dot
  * dot-n
  * dot-o
  * dot-p

for example:
$myname lineage lineage-15.1

EOF
}


if [ -z "$2" ];then
	>&2 help
else

rom=$1
branch=$2

sudo apt-get update
sudo apt-get install openjdk-8-jdk phablet-tools git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip schedtool meld lzop maven bc -y
git config --global user.name "Chau Truong Thinh"
git config --global user.email "chautruongthinh@gmail.com"

if [ "$rom" == "cdroid" ];then
	mkdir -p $rom"_"$branch
	cd $rom"_"$branch
	repo init -u https://github.com/crdroidandroid/android.git -b $branch
elif [ "$rom" == "lineage" ];then
	mkdir -p $2
	cd $2
	repo init -u https://github.com/LineageOS/android.git -b $branch
elif [ "$rom" == "rr" ];then
	mkdir -p "rr_"$branch
	cd "rr_"$branch
	repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b $branch
elif [ "$rom" == "dot" ];then
	mkdir -p $branch
	cd $branch
	repo init -u https://github.com/DotOS/manifest.git -b $branch
fi

function clone() {
    git clone https://github.com/chautruongthinh/local_manifests.git -b $branch .repo/local_manifests
}

## clone manifest
read -p "Do you want to clone local_manifest? (y/N) " clone


if [[ $clone == *"y"* ]];then
clone
fi

repo sync -j32 --force-sync

# use ccache
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
prebuilts/misc/linux-x86/ccache/ccache -M 50G
echo -e "export USE_CCACHE=1 \nexport CCACHE_DIR=~/.ccache" >> .bashrc

cd ~

curl -O https://raw.githubusercontent.com/chautruongthinh/google_clouds/ubuntu_16.0.4/build.sh

## compile rom
function sync_repo() {
~/build.sh
}

read -p "Do you want to compile now? (y/N) " compile
if [[ $compile == *"y"* ]];then
compile
fi

fi


