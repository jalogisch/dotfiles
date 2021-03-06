umask 022

# editor
export EDITOR=vim

# usefull
alias confcat="sed -e 's/[#;].*//;/^\s*$/d' "$@""
alias dl="aria2c --seed-time 1 --seed-ratio 0.1 -j4 -i --save-session=out.txt"

utf8()
{
        iconv -f ISO-8859-1 -t UTF-8 $1 > $1.tmp
            rm $1
            mv $1.tmp $1
}
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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

# go some dirs up 
#http://www.sudobash.net/bash-functions/
up () {

        if [[ $1 != '' ]]; then
         COUNTER=$1
        else
         COUNTER=1
        fi
        while [[ $COUNTER -gt 0 ]]
         do
          UP="${UP}../"
          COUNTER=$(( $COUNTER -1 ))
         done
        echo "cd $UP"
        cd $UP
        UP=''
}

# find dirs with most space usage
#http://www.sudobash.net/bash-functions/
function spaceHog () 
{ 
    du -k | sort -n | awk '
BEGIN {
    split("KB,MB,GB,TB", Units, ",");
}
{
    u = 1;
    while ($1 >= 1024) {
        $1 = $1 / 1024; 
        u += 1;
    }
    $1 = sprintf("%.1f %s", $1, Units[u]);
    print $0;
}'
}


# Shell Prompt Build
if [ "$PS1" ]; then
 
    # changes the window title in terminals like putty or konsole
    echo -ne "\033]0; ${USER}@${HOSTNAME}  +${SHLVL} @${SSH_TTY/\/dev\/} - `uptime` \007"

    # check if there is a repo (svno r git) and show some information
    scm_ps1() {
    		local s=
    		if [[ -d ".svn" ]] ; then # we got SVN Repo
        		s=\(svn:$(svn info | sed -n -e '/^Revision: \([0-9]*\).*$/s//\1/p' )\)
    		elif type __git_ps1 2>&1>/dev/null; then # we got GIT Repo (and tools for that)
        		s=$(__git_ps1 "(git:%s)")
    		else # we got nothing here
       			s=
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
