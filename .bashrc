# test if interactive
if [ ! -z "$PS1" ]; then
	stty werase undef
	bind '"\C-w": backward-kill-word'
	# bind '"\C-j": unix-word-rubout' # causes iTerm+Go2Shell fuckups and messes
    # up tmux send-keys

	# Lang env variable
	export LC_ALL=en_US.UTF-8 # w/o this, can't import e.g. matplotlib? wtf?
	export LANG=en_US.UTF-8


	# ================================================================================
	# Change command line prompt into a penis with length proportional to the
	# distance from root

	# repeat char n times (found on SO)
	repl() { printf "$1"'%.s' $(eval "echo {1.."$(($2))"}"); }

	# print distance from root. This works only correctly if there is no slash at
	# the end of the path given.
	depth() {
		if [ "$1" = '/' ]; then
			echo 1
		else
			echo $(echo "$1/" | grep -o "/" | wc -l)
		fi
	}
	# export PS1='\[\e[33m\]\W\[\e[m\] '
	# ================================================================================

	export EDITOR=vim
	export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # don't remember what this is for
	export CLICOLOR=1

	alias make='make -j4'
	alias la='ls -a'
	alias ls='ls -F'

	alias vi='vim'
	alias pytest='py.test'

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

	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'

	# Own PS1 settings.
	# Git info in prompt
	COLOR_RED="\033[01;31m"
	COLOR_YELLOW="\033[01;33m"
	COLOR_GREEN="\033[0;32m"
	COLOR_OCHRE="\033[38;5;95m"
	COLOR_BLUE="\033[0;34m"
	COLOR_WHITE="\033[0;37m"
	COLOR_RESET="\033[0m"

	function git_color {
		local git_status="$(git status 2> /dev/null)"

		if [[ ! $git_status =~ "working directory clean" ]]; then
			echo -e $COLOR_RED
		elif [[ $git_status =~ "Your branch is ahead of" ]]; then
			echo -e $COLOR_YELLOW
		elif [[ $git_status =~ "nothing to commit" ]]; then
			echo -e $COLOR_GREEN
		else
			echo -e $COLOR_OCHRE
		fi
	}

	function git_branch {
	local git_status="$(git status 2> /dev/null)"
	local on_branch="On branch ([^${IFS}]*)"
	local on_commit="HEAD detached at ([^${IFS}]*)"

	if [[ $git_status =~ $on_branch ]]; then
		local branch=${BASH_REMATCH[1]}
		echo "($branch)"
	elif [[ $git_status =~ $on_commit ]]; then
		local commit=${BASH_REMATCH[1]}
		echo "($commit)"
	fi
	}

	# PS1+="\[$COLOR_WHITE\][\W]"          # basename of pwd
	PS1+="\[\$(git_color)\]"        # colors git status
	PS1+=" \$(git_branch)"           # prints current branch
	PS1+="\[$COLOR_WHITE\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'
	export PS1
	export CCACHE_DIR=/local/.ccache
	alias open="xdg-open"

	export PATH=$PATH:$PYTHONPATH
	export PATH=/usr/local/bin:$PATH # for newly compiled vim

	alias dick=git
	source ~/tmux.completion.bash

    # https://unix.stackexchange.com/a/217223/208945
    # Avoid being asked to unlock private key when ssh'ing from this machine when I'm ssh'ed into it
    if [ ! -S ~/.ssh/ssh_auth_sock ]; then
        eval `ssh-agent`
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    ssh-add -l > /dev/null || ssh-add

    export PATH=$PATH:~/.local/bin:/home/student/r/rdiederichse/Downloads/Sources/slam6d-code/bin/

    alias catkin_make=catkin_boi
    # export TERM=xterm-256color

    alias mv="mv -n"
fi

# added by Miniconda3 installer
export PATH="$PATH:/home/student/r/rdiederichse/miniconda3/bin"
TF=~/Documents/TensorBros/ann-tensorflow

export PLUTO_WORKSPACE=/local/pluto_workspace

pg_pluto()
{
    source "$PLUTO_WORKSPACE/devel/setup.bash"
}

SECS=1
rosmux() {
    # why run pg_pluto at start of every session? dunno why, but the sessions
    # don't seem to inherit env vars unless we sleep excessively ¯\_(ツ)_/¯
    tmux new-session -ds pg-roscore
    sleep $SECS
    tmux send-keys -t pg-roscore "pg_pluto && roscore" Enter
    echo "Session: roscore started."
    sleep $SECS
    tmux new-session -ds pg-edit
    tmux send-keys -t pg-edit "pg_pluto && roscd hyperspectral_calibration" Enter
    echo "Session: edit started."
    tmux new-session -ds pg-rosbag
    tmux send-keys -t pg-rosbag "pg_pluto" Enter
    echo "Session: rosbag started."
    tmux new-session -ds pg-compile
    tmux send-keys -t pg-compile "pg_pluto && cd $PLUTO_WORKSPACE" Enter
    tmux send-keys -t pg-compile "catkin_make -DCMAKE_BUILD_TYPE=Debug -j7" Enter
    echo "Session: compile started."
    tmux new-session -ds pg-roslaunch
    tmux send-keys -t pg-roslaunch "pg_pluto" Enter
    # tmux split-window -v
    # tmux send-keys -t pg-roslaunch:0.0 "roslaunch hyperspectral_calibration colorize_cloud.launch use_rgb_only:=false start_pylon_driver:=true outdoor:=false"
    echo "Session: roslaunch started."
    tmux new-session -ds pg-riegl
    tmux split-window -v
    tmux send-keys -t pg-riegl:0.0 "pg_pluto && roslaunch riegl_driver riegl_vz400i.launch fields:=2" Enter
    tmux send-keys -t pg-riegl:0.1 "pg_pluto && roslaunch riegl_vline_teleop riegl_vz400i.launch phi_min:=270 phi_max:=330 theta_min:=30 theta_max:=150 phi_incr:=1 theta_incr:=1"
    echo "Session: riegl started."
    tmux new-session -ds pg-rviz
    tmux send-keys -t pg-rviz "sleep 1" Enter
    tmux send-keys -t pg-rviz "pg_pluto && rviz" Enter
    echo "Session: rviz started."
}

tfmux() {
    cd ~/Documents/TensorBros/ann-tensorflow
    tmux new-session -ds tf-edit
    tmux send-keys -t tf-edit "source activate tfenv" Enter
    tmux new-session -ds tf-run
    tmux send-keys -t tf-run "source activate tfenv" Enter
    tmux new-session -ds tf-jupyter
    tmux send-keys -t tf-jupyter "source activate tfenv" Enter
    tmux send-keys -t tf-jupyter "jupyter notebook" Enter
    tmux new-session -ds tf-ipython
    tmux send-keys -t tf-ipython "source activate tfenv" Enter
    tmux send-keys -t tf-ipython "ipython" Enter
}

cvmux() {
    sshfs rdiederichse@bias.cv.uos.de:/home/student/r/rdiederichse ~/bias\@cv/
    cd ~/bias@cv/qtpyvis
    tmux new-session -ds cv-edit
    tmux send-keys -t cv-edit "source activate rdiederichse-env" Enter
    tmux new-session -ds cv-install
    tmux send-keys -t cv-install "source activate rdiederichse-env" Enter
    tmux new-session -ds cv-monitor
    tmux send-keys -t cv-monitor "source activate rdiederichse-env" Enter
    tmux new-session -ds cv-run
    tmux send-keys -t cv-run "source activate rdiederichse-env" Enter
}

export CUDA_HOME=/usr/local/cuda
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"
export PATH="$CUDA_HOME/bin:$PATH"
