# supplied via puppet

export PS1='\h:\w\$ '
umask 022

# editor
export EDITOR=vim

# usefull
alias confcat="sed -e 's/[#;].*//;/^\s*$/d' "$@""
alias dl="aria2c --seed-time 1 --seed-ratio 0.1 -j4 -i --save-session=out.txt"

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -lah'
alias l='ls $LS_OPTIONS -lA'
 
# Some more alias to avoid making mistakes:
alias rm='rm -i'
# alias cp='cp -i'
alias mv='mv -i'

if [ -d $HOME/.rbenv/bin/ ];then
  export PATH=$HOME/.rbenv/bin/:$PATH
  eval "$(rbenv init -)"
fi

if [ -d /opt/node/bin/ ];then
	export PATH=/opt/node/bin/:$PATH
fi
if [ -d /usr/local/rvm/bin ];then
	export PATH=/usr/local/rvm/bin:$PATH
fi

# 
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    	. /etc/bash_completion
fi

# Shell Prompt wird gebaut
if [ "$PS1" ]; then
 
    # set terminal titlebar
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/$HOME/~}\007"'
    # define the prompt

	parse_git_branch () {
 	   git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)# (git::\1)#'
	}
	parse_svn_branch() {
    	parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk '{print " (svn::"$1")" }'
	}	
	parse_svn_url() {
    	svn info 2>/dev/null | sed -ne 's#^URL: ##p'
	}
	parse_svn_repository_root() {
    	svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
	}

	scm_ps1() {
    local s=
    if [[ -d ".svn" ]] ; then
        s=\(svn:$(svn info | sed -n -e '/^Revision: \([0-9]*\).*$/s//\1/p' )\)
    else
        s=$(__git_ps1 "(git:%s)")
    fi
    echo -n "$s"
}

	BLACK="\[\033[0;38m\]"
	RED="\[\033[0;31m\]"
	RED_BOLD="\[\033[01;31m\]"
	BLUE="\[\033[01;34m\]"
	GREEN="\[\033[0;32m\]"

	#PS1='\[\e[31m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]:\[\e[36m\]\w\n\d  \t> \[\e[0m\]'
	PS1="$BLACK[ \u@$RED\H:$GREEN\w$RED_BOLD \$(scm_ps1)$BLACK ]\n\d  \t # \[\e[0m\]"
	export PS1
fi
