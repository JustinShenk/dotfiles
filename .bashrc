# test if interactive
if [ ! -z "$PS1" ]; then
    stty werase undef
    bind '"\C-w": backward-kill-word'
    # bind '"\C-j": unix-word-rubout' # causes iTerm+Go2Shell fuckups and messes
    # up tmux send-keys

    # Lang env variable
    export LC_ALL=en_US.UTF-8 # w/o this, can't import e.g. matplotlib? wtf?
    export LANG=en_US.UTF-8


    export EDITOR=vim
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # don't remember what this is for
    export CLICOLOR=1

    # color grep commands
    alias grep='grep --color=auto'
    alias make='make -j4'
    alias la='ls -a'
    alias ls='ls -FG'
    alias ll='ls -ahl'
    # print large files
    alias diskspace="du -S | sort -n -r |more"
    # show size of folders in current dir
    alias folders='find . -maxdepth 1 -type d -print0 | xargs -0 du -skh | sort -h'

    alias ..="cd .."
    alias ...="cd ../.."
    alias ....="cd ../../.."
    alias .....="cd ../../../.."

    alias mv="mv -n"
    alias dick=git
    alias vi='vim'
    alias pytest='py.test'


    # extract any archive. Alternative: `sudo apt install unp`
    extract () {
       if [ -f $1 ] ; then
           case $1 in
               *.tar.bz2)   tar xvjf $1    ;;
               *.tar.gz)    tar xvzf $1    ;;
               *.bz2)       bunzip2 $1     ;;
               *.rar)       unrar x $1     ;;
               *.gz)        gunzip $1      ;;
               *.tar)       tar xvf $1     ;;
               *.tbz2)      tar xvjf $1    ;;
               *.tgz)       tar xvzf $1    ;;
               *.zip)       unzip $1       ;;
               *.Z)         uncompress $1  ;;
               *.7z)        7z x $1        ;;
               *)           echo "don't know how to extract '$1'..." ;;
           esac
       else
           echo "'$1' is not a valid file!"
       fi
    }

    # Color for manpages in less makes manpages a little easier to read:
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;31m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;44;33m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[01;32m'


    # enable ctrl-s
    stty -ixon

    # dedup history
    export HISTCONTROL=ignoreboth:erasedups

    ################################################################################
    #                       Stuff from mrzool/bash-sensible                        #
    ################################################################################
    # Unique Bash version check
    if ((BASH_VERSINFO[0] < 4))
    then
        echo "sensible.bash: Looks like you're running an older version of Bash."
        echo "sensible.bash: You need at least bash-4.0 or some options will not work correctly."
        echo "sensible.bash: Keep your software up-to-date!"
    fi

    # Prevent file overwrite on stdout redirection
    # Use `>|` to force redirection to an existing file
    set -o noclobber

    # Automatically trim long paths in the prompt (requires Bash 4.x)
    PROMPT_DIRTRIM=2
    #
    # Case-insensitive globbing (used in pathname expansion)
    shopt -s nocaseglob;

    # Perform file completion in a case insensitive fashion
    bind "set completion-ignore-case on"

    # Display matches for ambiguous patterns at first tab press
    bind "set show-all-if-ambiguous on"

    # Immediately add a trailing slash when autocompleting symlinks to directories
    bind "set mark-symlinked-directories on"

    # Append to the history file, don't overwrite it
    shopt -s histappend

    # Save multi-line commands as one command
    shopt -s cmdhist

    # Record each line as it gets issued
    PROMPT_COMMAND='history -a'

    # Huge history. Doesn't appear to slow things down, so why not?
    HISTSIZE=500000
    HISTFILESIZE=100000

    # Avoid duplicate entries
    HISTCONTROL="erasedups:ignoreboth"

    ## BETTER DIRECTORY NAVIGATION ##

    # Prepend cd to directory names automatically
    shopt -s autocd 2> /dev/null
    # Correct spelling errors during tab-completion
    shopt -s dirspell 2> /dev/null
    # Correct spelling errors in arguments supplied to cd
    shopt -s cdspell 2> /dev/null

    # This defines where cd looks for targets
    # Add the directories you want to have fast access to, separated by colon
    # Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
    CDPATH="."

    source ~/git-completion.bash

    function __setprompt {
      local BLUE="\[\033[0;34m\]"
      local NO_COLOUR="\[\033[0m\]"
      local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
      local SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`
      if [ $SSH2_IP ] || [ $SSH_IP ] ; then
        local SSH_FLAG="@\h"
      fi
      PS1="$BLUE[\u$SSH_FLAG:\w]\\$ $NO_COLOUR"
      PS2="$BLUE>$NO_COLOUR "
      PS4='$BLUE+$NO_COLOUR '
    }
    __setprompt

    export PATH=$PATH:$PYTHONPATH
    export PATH=/usr/local/bin:$PATH # for newly compiled vim

    source ~/tmux.completion.bash

    # https://unix.stackexchange.com/a/217223/208945
    # Avoid being asked to unlock private key when ssh'ing from this machine when I'm ssh'ed into it
    if [ ! -S ~/.ssh/ssh_auth_sock ]; then
        eval `ssh-agent`
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    ssh-add -l > /dev/null || ssh-add

    # must press ctrl-D twice to exit
    export IGNOREEOF="1"
fi

case "$OSTYPE" in
  darwin*)  source ~/.macrc ;;
  linux*)   source ~/.ubunturc ;;
  bsd*)     echo "BSD" ;;
  msys*)    echo "WINDOWS" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac
