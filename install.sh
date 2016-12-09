#!/bin/bash
set -e

THIS_DIR="$(pwd)/$(dirname $0)/"

function install
{
        [ -z "$1" ] && exit 1
        [ -z "$2" ] && exit 2

        OLD_FILE=$1
        FILE_NAME=$2

        if [ -e $OLD_FILE ]; then
                echo "Backing up current $FILE_NAME"
                mv -i -v $OLD_FILE ${OLD_FILE}_old
        fi
        echo "Installing hardlink"
        ln -v ${THIS_DIR}${FILE_NAME} $OLD_FILE
}

while [ -n "$1" ]; do
        if [ "-b" == "$1" ]; then
                install ~/.bashrc ".bashrc"
                shift
        fi
        if [ "-c" == "$1" ]; then
                install ~/.conkyrc ".conkyrc"
                shift
        fi
        if [ "-v" == "$1" ]; then
                install ~/.vimrc ".vimrc"
                shift
        fi
done
