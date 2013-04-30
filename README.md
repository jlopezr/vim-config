vim-config
==========

Installation
------------
    cd ~
    ln -s ~/.vim/vimrc ~/.vimrc 
    git clone https://github.com/jlopezr/vim-config.git .vim
    cd .vim
    git submodule update --init --recursive
    vim
    :BundleUpdate

Don't forget to add TERM environment variable to .bashrc
    export TERM=xterm-256color
