export LANG=ja_JP.UTF-8
export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
export PATH="/usr/local/bin:$PATH"
export NODE_PATH=$HOME/.npm/lib:$PATH
export PATH=$HOME/.npm/bin:$PATH
export PATH=/Applications/Xcode6-Beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/:$PATH
export MANPATH=$HOME/.npm/man:$MANPATH
export SCREENDIR=$HOME/.screen
alias java='java -Dfile.encoding=UTF-8'
alias javac='javac -J-Dfile.encoding=utf-8'

alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

############################################################
# aliases
############################################################
alias ls='ls -FG'
alias gh='history 0 | grep --color '
alias l='less'
alias g='grep --color'
alias -g G='| grep --color'
alias -g L='| less'
alias where='command -v'
alias du='du -h'
alias df='df -h'
alias vz='vim ~/.zshrc && . ~/.zshrc'
alias screen="$HOME/local/bin/screen"
alias be='bundle exec'

autoload zmv
alias zmv='noglob zmv'

############################################################
# prompt
############################################################

#autoload promptinit
#promptinit
#prompt adam2
PROMPT="%n%% "
RPROMPT="[%~]"
SPROMPT="correct: %R -> %r ? " 

autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
        local name st color gitdir action
        if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi

        gitdir=`git rev-parse --git-dir 2> /dev/null`
        action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=%F{green}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=%F{yellow}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=%B%F{red}
        else
                 color=%F{red}
         fi
              
        echo "$color$name$action%f%b"
}

setopt prompt_subst

PROMPT='%n[`rprompt-git-current-branch`]%% '
#RPROMPT='[`rprompt-git-current-branch`%~]'

############################################################
# prompt
############################################################

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups hist_save_no_dups
setopt share_history
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt hist_ignore_space
setopt auto_list

bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


############################################################
# auto complete
############################################################

autoload -U compinit
compinit

autoload predict-on
#predict-on

setopt auto_cd
setopt correct
setopt list_packed
setopt complete_aliases
setopt COMPLETE_IN_WORD

zstyle ':completion:*' list-colors ''


############################################################
# auto complete
############################################################


## keep background processes at full speed
setopt NOBGNICE
## restart running processes on exit
setopt HUP

## never ever beep ever
setopt NO_BEEP

autoload -U colors
colors

if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

# cd ~/
function h() {
    cd
    if [ $# = 1 ]; then
        cd 
    fi
}

function up()
{
    to=$(perl -le '$p=$ENV{PWD}."/";$d="/".$ARGV[0]."/";$r=rindex($p,$d);\
                   $r>=0 && print substr($p, 0, $r+length($d))' )
    if [ "$to" = "" ]; then
        echo "no such file or directory: " 1>&2
        return 1
    fi
    cd $to
}
fpath=(~/.functions ${fpath})


stty stop undef

local COMMAND=""
local COMMAND_TIME=""
precmd() {
  if [ "$COMMAND_TIME" -ne "0" ] ; then
    local d=`date +%s`
    d=`expr $d - $COMMAND_TIME`
    if [ "$d" -ge "30" ] ; then
      COMMAND="$COMMAND "
      growlnotify -t "${${(s: :)COMMAND}[1]}" -m "$COMMAND"
    fi
  fi
  COMMAND="0"
  COMMAND_TIME="0"
}
preexec () {
  COMMAND="${1}"
  COMMAND_TIME=`date +%s`
  }

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
