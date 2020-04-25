#!/bin/bash
alias ll='ls -lh'

export HISTTIMEFORMAT="%F %T "

if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

function parse_git_branch() {
        BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
        if [ ! "${BRANCH}" == "" ]
        then
                STAT=`parse_git_dirty`
                echo "[${BRANCH}${STAT}]"
        else
                echo ""
        fi
}

function parse_git_dirty {
        status=`git status 2>&1 | tee`
        dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
        untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
        ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
        newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
        renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
        deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
        bits=''
        if [ "${renamed}" == "0" ]; then
                bits=">${bits}"
        fi
        if [ "${ahead}" == "0" ]; then
                bits="*${bits}"
        fi
        if [ "${newfile}" == "0" ]; then
                bits="+${bits}"
        fi
        if [ "${untracked}" == "0" ]; then
                bits="?${bits}"
        fi
        if [ "${deleted}" == "0" ]; then
                bits="x${bits}"
        fi
        if [ "${dirty}" == "0" ]; then
                bits="!${bits}"
        fi
        if [ ! "${bits}" == "" ]; then
                echo " ${bits}"
        else
                echo ""
        fi
}

function nonzero_return() {
        RETVAL=$?
        [ $RETVAL -ne 0 ] && echo "$RETVAL" || echo "\[\e[32m\]OK\[\e[m\]"
}

function get_host_ip(){
 echo $(ip a show eth0 | grep inet | head -1 | awk '{print $2}' | awk -F '/' '{print $1}')
}

export PS1="\n[\[\e[33m\]LastStatus \[\e[m\]`nonzero_return`]\n\[\e[31m\]\u\[\e[m\]@\[\e[36m\]`get_host_ip`\[\e[m\][\h]:\[\e[35m\]\w\[\e[34m\]\`parse_git_branch\`\[\e[m\]\n\[\e[33m\][\D{%Y-%m-%d %H:%M:%S}]\[\e[m\]\s \[\e[31m\]\\$\[\e[m\]  \[\e(0\]b\[\e(B\] "
