git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer --go-completer --java-completer --rust-completer --ts-completer --enable-coverage
