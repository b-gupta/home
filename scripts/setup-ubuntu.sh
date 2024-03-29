#!/bin/bash

#echo "source ~/.bashrc_bharat" >> ~/.bashrc
# required packages
sudo apt update
sudo apt -y install git build-essential cmake python3-dev nodejs npm vim autokey-gtk pip fish

# setup fzf (fuzzy completion)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# setup vim
git clone https://github.com/sickill/vim-monokai.git /tmp/vim-monokai
mkdir -p ~/.vim/colors && cp /tmp/vim-monokai/colors/*.vim ~/.vim/colors

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# try without YouCompleteMe
# git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
# cd ~/.vim/bundle/YouCompleteMe
# git submodule update --init --recursive
# python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer --go-completer --java-completer --rust-completer --ts-completer --enable-coverage

vim +PluginInstall +qall
vim +GoInstallBinaries +qall
