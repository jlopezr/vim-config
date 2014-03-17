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

YouCompleteMe (YCM)
-------------------
    
Seems that vim version in Ubuntu 12.04 is quite old for YCM. In this case, you can compile vim 7.4 by hand or disable YCM.

    cd ~
    hg clone https://code.google.com/p/vim/
    cd vim
    ./configure --with-features=huge \
                --enable-rubyinterp \
                --enable-pythoninterp \
                --enable-perlinterp \
                --enable-gui=gtk2 --enable-cscope --prefix=/usr/local/stow/vim-7.4
    make 
    sudo make install
    cd /usr/local/stow
    sudo stow vim-7.4
    sudo update-alternatives --install /usr/local/bin/editor editor /usr/local/bin/vim 1
    sudo update-alternatives --set editor /usr/local/bin/vim
    sudo update-alternatives --install /usr/local/bin/vi vi /usr/local/bin/vim 1
    sudo update-alternatives --set vi /usr/local/bin/vim

In addition to this, is needed to compile YCM support.

    sudo apt-get install cmake
    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer
