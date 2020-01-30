prompt() {
    echo -n "$1 already exists. Overwrite? [yN]"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        return 0
    else
        return 1
    fi
}

install_file() {
    local should_link="No"
    if [ -f $HOME/$1 ] || [ -d $HOME/$1 ]; then
        if prompt "$HOME/$1"; then
            mv -f $HOME/$1 $HOME/$1.bak
            should_link="Yes"
        fi
    else
        should_link="Yes"
    fi
    if [ $should_link == "Yes" ]; then
        ln -s `pwd`/$1 $HOME/$1
        return 0
    else
        return 1
    fi
}


os=$(uname)

if [ $os == "Linux" ]; then
    install_file .ubunturc
fi

if [ $os == "Darwin" ]; then
    install_file .macrc
fi

install_file .inputrc
install_file .profile
install_file .bashrc
install_file .bash_login
install_file .macrc
install_file .gitconfig
install_file .tmux.conf
install_file tmux.completion.bash
install_file git-completion.bash
install_file .vim
install_file .bash_logout

# vim_version = $(vim --version | grep "Vi IMproved [0-9]\.[0-9]\+" | cut -d " " -f 5)
if install_file .vimrc; then
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | \
        sh -s -- $HOME/.vim/bundle
    vim -c "if v:version >= 800|call dein#update()|quit|else|quit"
fi
