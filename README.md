# dotfiles
 - .zshrc
 - .vimrc
 - ghostty/config
 - zellij/config.kdl

# Usage
## terminal
    git clone https://github.com/takak/dotfiles.git
    cd dotfiles
    sh symlink.sh

## vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    git clone --branch release --depth 1 https://github.com/neoclide/coc.nvim.git ~/.vim/bundle/coc.nvim  # coc.nvimはビルド済みのreleaseブランチを使う
    vim  # 起動後に以下を実行
    :BundleInstall

## ghostty
    mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
    ln -s ~/dotfiles/ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/config

## zellij
    mkdir -p ~/.config/zellij
    mv ~/.config/zellij/config.kdl ~/.config/zellij/config.kdl.bak  # zellij起動済みだとconfig.kdlが自動生成されていてlnがFile existsになるので退避する(無ければ不要)
    ln -s ~/dotfiles/zellij/config.kdl ~/.config/zellij/config.kdl
