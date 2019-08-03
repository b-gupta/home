echo "source ~/.bashrc_bharat" >> ~/.bashrc
apt upgrade

# setup vim
apt install vim --assume-yes

# setup fzf (fuzzy completion)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
