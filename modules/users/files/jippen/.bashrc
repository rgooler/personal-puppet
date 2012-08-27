# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#ssh-agent
export SSH_AGENT_PID=`pgrep -u $USER ssh-agent`
if [[ "$SSH_AGENT_PID" == "" ]]; then
  eval `ssh-agent` >/dev/null
else
  export SSH_AUTH_SOCK=`find /tmp -name agent.$(expr $SSH_AGENT_PID - 1) 2>/dev/null`
fi
if `ssh-add -l | fgrep "agent has no identities" >/dev/null`; then
  for key in $HOME/.ssh/*.pub; do
    ssh-add -t 24h $HOME/.ssh/`basename $key .pub`
  done
fi

export PATH=$PATH:$HOME/bin:$HOME/git/assistly/operations/bin:/usr/local/ec2/bin:/usr/local/aws-iam-tools/bin:/usr/local/elb/bin
export EDITOR=vim
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\]:\w\[\033[31m\]$(__git_ps1 "(%s)") \[\033[01;34m\]$\[\033[00m\] '

export AWS_CREDENTIAL_FILE="$HOME/.ec2/rgooler.credentials" 
export EC2_PRIVATE_KEY="$HOME/.ec2/rgooler.key" 
export EC2_CERT="$HOME/.ec2/rgooler.crt"
export EC2_HOME="/usr/local/ec2"
export JAVA_HOME="/usr"
export AWS_IAM_HOME="/usr/local/aws-iam-tools"
export AWS_ELB_HOME="/usr/local/elb"

new() {
  if [[ "$1" == "" ]]; then
    echo "Missing JIRA issue number"
    return
  fi
  if [[ "`__git_ps1`" == "" ]]; then
    echo "You must be in a git repo"
    return
  fi
  git checkout -b $1 || git checkout $1
}

submit() {
  if [[ "$1" == "" ]]; then
    echo "Missing commit comment"
    return
  fi
  if [[ "`__git_ps1`" == "" ]]; then
    echo "You must be in a git repo"
    return
  elif [[ "`__git_ps1`" =~ master ]]; then
    echo "You must be in a branch"
    return
  else
    ISSUE=`__git_ps1 | sed -e 's/[\(\) ]//g'`
  fi
  git add .
  git commit -a -m "$ISSUE $1"
  git push origin $ISSUE
  git fetch upstream
  git checkout master
  git pull upstream master
  git checkout $ISSUE
  git rebase master && echo "https://github.com/jippen/assistly-puppet/pull/new/$ISSUE"
}

cleanup() {
  if [[ "`__git_ps1`" == "" ]]; then
    echo "You must be in a git repo"
    return
  else
    ISSUE=`__git_ps1 | sed -e 's/[\(\) ]//g'`
  fi
  git pull origin $ISSUE
  git push
  git checkout master
  git pull upstream master
  git push
}

githelp() {
  echo "    new: Prepare repo for work"
  echo " submit: Push changes upstream"
  echo "cleanup: Reset repo to master"
}

. /etc/bash_completion
. /etc/bash.functions
