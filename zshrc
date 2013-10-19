# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=12800
SAVEHIST=$HISTSIZE
setopt appendhistory autocd nomatch
bindkey -e

#########
#ALIASES#
#########
alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -al"
alias du="du -h --max-depth=1"
alias grep="grep --color=auto"
alias rm="rm -i"
alias mv="mv -i"
alias psgr="ps -ef|grep"
alias battery="acpi -b"
alias winhome="cd /mnt/sda3/Users/yucachaaaan"
alias drives="cd /mnt"
alias wakarimasenlol="ssh nadeko.tsundere.my"
alias -s {mpg,mpeg,avi,ogm,wmv,m4v,mp4,mov,mkv}='mpv -ass -vf screenshot'
alias -s {png, jpg, gif, bmp}='gpicview'
alias bright="xbacklight +10"
alias dim="xbacklight -10"
alias sleep='sudo pm-suspend'
alias screenshot='bash /home/yucachaaaan/imgur'
alias music="sudo mpd && mpdscribble"
alias startx="sudo cardoff && startx"
alias mpd="sudo mpd"

########
#PROMPT#
########
PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[0m%} @ %{\e[0m%}%{\e[0;36m%}%B%m%{\e[0;34m%}%B]%b%{\e[0m%}-%{\e[0;34m%}%B[%b%{\e[0;34m%}'%B%*%b$'%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─[%b%{\e[0m%}%~%{\e[0;34m%}%B]%b%{\e[0;34m%}-%B[%{\e[1;35m%}$%{\e[0;34m%}%B]>%{\e[0m%}%b '


zstyle :compinstall filename '/home/yucachaaaan/.zshrc'

autoload -Uz compinit
compinit

