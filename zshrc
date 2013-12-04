# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=12800
SAVEHIST=$HISTSIZE
setopt appendhistory autocd nomatch
bindkey -e
# Binds
# Alt+x to insert sudo
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^X" insert-sudo
bindkey '^U' backward-kill-line
bindkey '^A' beginning-of-line
bindkey '^D' end-of-line
bindkey -a 'gg' beginning-of-buffer-or-history

bindkey "^["    vi-cmd-mode
bindkey -M vicmd 'u' undo

TERM=rxvt-unicode

# Syntax Highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor) 
source /home/yucachaaaan/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# STYLES
# Aliases and functions
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue,bold'

# Commands and builtins
ZSH_HIGHLIGHT_STYLES[command]="fg=blue,bold"
ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=blue,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=blue,bold"

# Paths
ZSH_HIGHLIGHT_STYLES[path]='fg=white'

# Globbing
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow,bold'

# Options and arguments
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=red'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=red'

ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=green"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=green"

# PATTERNS
# rm -rf
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

# Sudo
ZSH_HIGHLIGHT_PATTERNS+=('sudo ' 'fg=white,bold,bg=red')


# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# show waiting dots for tab completion
expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# Token types styles.
# See http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#SEC135
ZLE_RESERVED_WORD_STYLE='fg=yellow'
ZLE_ALIAS_STYLE='fg=magenta'
ZLE_BUILTIN_STYLE='fg=cyan'
ZLE_FUNCTION_STYLE='fg=blue'
ZLE_COMMAND_STYLE='fg=green'
ZLE_COMMAND_UNKNOWN_TOKEN_STYLE='fg=red'

ZLE_HYPHEN_CLI_OPTION='fg=yellow'
ZLE_DOUBLE_HYPHEN_CLI_OPTION='fg=green'
ZLE_SINGLE_QUOTED='fg=magenta'
ZLE_DOUBLE_QUOTED='fg=red'
ZLE_BACK_QUOTED='fg=cyan'
ZLE_GLOBING='fg=blue'

ZLE_DEFAULT='fg=white'

ZLE_TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'start' 'time' 'strace' '§')

# Recolorize the current ZLE buffer.
colorize-zle-buffer() {
  region_highlight=()
  colorize=true
start_pos=0
  for arg in ${(z)BUFFER}; do
    ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
    ((end_pos=$start_pos+${#arg}))
    if $colorize; then
colorize=false
res=$(LC_ALL=C builtin type $arg 2>/dev/null)
      case $res in
        *'reserved word'*) style=$ZLE_RESERVED_WORD_STYLE;;
        *'an alias'*) style=$ZLE_ALIAS_STYLE;;
        *'shell builtin'*) style=$ZLE_BUILTIN_STYLE;;
        *'shell function'*) style=$ZLE_FUNCTION_STYLE;;
        *"$cmd is"*) style=$ZLE_COMMAND_STYLE;;
        *) style=$ZLE_COMMAND_UNKNOWN_TOKEN_STYLE;;
      esac
else
case $arg in
'--'*) style=$ZLE_DOUBLE_HYPHEN_CLI_OPTION;;
'-'*) style=$ZLE_HYPHEN_CLI_OPTION;;
"'"*"'") style=$ZLE_SINGLE_QUOTED;;
'"'*'"') style=$ZLE_DOUBLE_QUOTED;;
'`'*'`') style=$ZLE_BACK_QUOTED;;
*"*"*) style=$ZLE_GLOBING;;
*) style=$ZLE_DEFAULT;;
esac
fi
region_highlight+=("$start_pos $end_pos $style")
    [[ ${${ZLE_TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
start_pos=$end_pos
  done
}

# Bind the function to ZLE events.
ZLE_COLORED_FUNCTIONS=(
    self-insert
    delete-char
    backward-delete-char
    kill-word
    backward-kill-word
    up-line-or-history
    down-line-or-history
    beginning-of-history
    end-of-history
    undo
    redo
    yank
)

for f in $ZLE_COLORED_FUNCTIONS; do
eval "$f() { zle .$f && colorize-zle-buffer } ; zle -N $f"
done

# Expand or complete hack
# Thanks to James Ahlborn :

# create an expansion widget which mimics the original "expand-or-complete" (you can see the default setup using "zle -l -L")
zle -C orig-expand-or-complete .expand-or-complete _main_complete

# use the orig-expand-or-complete inside the colorize function (for some reason, using the ".expand-or-complete" widget doesn't work the same)
expand-or-complete() { builtin zle orig-expand-or-complete && colorize-zle-buffer }
zle -N expand-or-complete


# utility functions
# this function checks if a command exists and returns either true
# or false. This avoids using 'which' and 'whence', which will
# avoid problems with aliases for which on certain weird systems. :-)
# Usage: check_com [-c|-g] word
#   -c  only checks for external commands
#   -g  does the usual tests and also checks for global aliases
check_com() {
    emulate -L zsh
    local -i comonly gatoo

    if [[ $1 == '-c' ]] ; then
        (( comonly = 1 ))
        shift
    elif [[ $1 == '-g' ]] ; then
        (( gatoo = 1 ))
    else
        (( comonly = 0 ))
        (( gatoo = 0 ))
    fi

    if (( ${#argv} != 1 )) ; then
        printf 'usage: check_com [-c] <command>\n' >&2
        return 1
    fi

    if (( comonly > 0 )) ; then
        [[ -n ${commands[$1]}  ]] && return 0
        return 1
    fi

    if   [[ -n ${commands[$1]}    ]] \
      || [[ -n ${functions[$1]}   ]] \
      || [[ -n ${aliases[$1]}     ]] \
      || [[ -n ${reswords[(r)$1]} ]] ; then

        return 0
    fi

    if (( gatoo > 0 )) && [[ -n ${galiases[$1]} ]] ; then
        return 0
    fi

    return 1
}

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
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

#mkcd
mkcd() {
    if (( ARGC != 1 )); then
        printf 'usage: mkcd <new-directory>\n'
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command mkdir -p "$1"
    else
        printf '`%s'\'' already exists: cd-ing.\n' "$1"
    fi
    builtin cd "$1"
}


# This will change your TTY colors tho those in your .Xresources
# Apply Xresources colors to the TTY
if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" /home/yucachaaaan/.Xresources | \
               awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
fi


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
alias mpd="sudo mpd"
alias startx="sudo stop && sudo systemctl start NetworkManager && sudo ip link set wlp7s0 up && startx"

########
#PROMPT#
########
#PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[0m%} @ %{\e[0m%}%{\e[0;36m%}%B%m%{\e[0;34m%}%B]%b%{\e[0m%}-%{\e[0;34m%}%B[%b%{\e[0;34m%}'%B%*%b$'%{\e[0;34m%}%B]%b%{\e[0m%}
#%{\e[0;34m%}%B└─[%b%{\e[0m%}%~%{\e[0;34m%}%B]%b%{\e[0;34m%}-%B[%{\e[1;35m%}#%{\e[0;34m%}%B]>%{\e[0m%}%b '
PROMPT=' %B%F{red}>> %f'
RPROMPT='%B%F{black}%~ %B%F{white}%#'
# Color command correction promt
autoload -U colors && colors
export SPROMPT="$fg[cyan]Correct $fg[red]%R$reset_color $fg[magenta]to $fg[green]%r?$reset_color ($fg[white]YES :: NO :: ABORT :: EDIT$fg[white])"



zstyle :compinstall filename '/home/yucachaaaan/.zshrc'
zmodload zsh/stat
zmodload zsh/complist
autoload zmv
autoload -U colors && colors
autoload -U vcs_info && vcs_info
autoload -Uz compinit
compinit

