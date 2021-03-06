# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export WINEARCH=win32

export MOZ_PLUGIN_PATH=~/.mozilla/plugins

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

#PS1="\[\033[01;37m\][\t] \j \w/\[\033[00;37m\]\n> "

__prompt_command() {
	local EXIT="$?"

    local C_RED="\[\e[1;31m\]"
    local C_YELLOW="\[\e[1;33m\]"
    local C_GREEN="\[\e[1;32m\]"
    local C_BLUE="\[\e[1;34m\]"

    if [ "0" -lt "$EXIT" ]; then
            EXIT="${C_RED}${EXIT}\[\e[1;37m\]"
    fi

    BRANCH_COLOR=${C_GREEN}

    STATUS="$(git status --porcelain 2>/dev/null)"

    if [ -n "$STATUS" ]; then
            if echo "$STATUS" | grep -v "^??" 1>/dev/null; then
                BRANCH_COLOR="${C_RED}"
            elif echo "$STATUS" | grep "^??" 1>/dev/null; then
                BRANCH_COLOR="${C_YELLOW}"
            fi
    fi

    local BRANCH="$(git branch 2>/dev/null| grep '\*' | cut -d ' ' -f2)"
    [ -n "$BRANCH" ] && BRANCH="b:${BRANCH_COLOR}${BRANCH}\[\e[1;37m\] "

    local JOBS="\j "
	# only count unfinished jobs, e.g "[1]+ ..."
    [ "0" -lt "$(jobs | grep '^\[[0-9]\+\]+' | wc -l)" ] && JOBS="${C_BLUE}${JOBS}\[\e[1;37m\]"
    
	PS1='\[\e[1;37m\]'
	PS1+='[\t] '
       	PS1+="${EXIT}"
	PS1+='/'
	PS1+="${JOBS}"
       	PS1+='\w/ '
    PS1+="${BRANCH}"
	PS1+='\[\033[00;37m\]'
	PS1+='\$ '
	PS1+='\n> '
}

export PROMPT_COMMAND=__prompt_command

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Meine Aliases
alias x='exit'
alias c='clear'
alias p='ping 8.8.8.8'
alias pse='echo "UID        PID  PPID  C STIME TTY          TIME CMD";ps -ef|grep'
alias upd='sudo apt-get update'
alias upg='sudo apt-get upgrade'
alias rm="rm -v"
alias cp="cp -v"
alias mv="mv -v"

alias af="apt-file search"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
