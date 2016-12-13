#!/bin/bash
set -e

THIS_DIR="$(dirname $0)/"

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

                if [ ! -d "~/.vim/bundle/Vundle.vim" ]; then
                        echo -n "Vundle is not installed. Download it now? [Y/n]"
                        read DECISION

                        case $DECISION in
                                [nN]*)
                                        echo ""
                                        echo "Not installed."
                                        ;;
                                *)
                                        echo "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
                                        if git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; then
                                                vim -S <(echo -e "VundleInstall \n q \n q")
                                        else
                                                "git clone failed."
                                        fi
                                        ;;
                        esac
                fi
                shift
        fi
done
