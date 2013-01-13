# dotfiles
 - .zshrc
 - .vimrc
 - .screenrc
 - .rvmrc

# Usage
## terminal
    git clone https://github.com/takak/dotfiles.git
    cd dotfiles
    git submodule update --init
    sh symlink.sh
    ln -s ~/dotfiles/vimfiles ~/.vim

## vim
    :BundleInstall
