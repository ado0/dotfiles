# Begining of the file
# Main conf dir is /etc/zsh/zshrc
# Written by Asmir; asmir [at] archlinux [dot] us

### Includes ###
#{{{ 
#Syntax highlight plugin
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# vi cursor mode status
#source ~/.zsh/vi_cursor_mode.zsh
#}}}

### Startup ###
#{{{
#transset -a .85 && clear
print -Pn "\e]2;%~\a"
if [ ! -f ~/.tmp_dir ]
then 
    echo $HOME >> ~/.tmp_dir
fi
cd $(cat ~/.tmp_dir) 
#fortune | cowsay -f `ls -1 /usr/share/cows/ | sort -R | head -1` -n
#echo "15" | angled
#}}}

### Aliases ###
#{{{
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
alias info="info --vi-keys"
alias l='ls -l'
alias ls='ls -b -CF --color=auto'
alias mpa="mpv --no-video"
alias nb="newsbeuter -q"
alias pd='popd'
alias p="proxychains"	
alias w2l="iconv -f windows-1252 -t utf-8 $1 > $2"
alias vimdiff='nvim -d'
alias vim='nvim'
alias passado='PASSWORD_STORE_DIR=~/.pass/ado pass'
alias passmenuado='PASSWORD_STORE_DIR=~/.pass/ado passmenu'
alias passmarvel='PASSWORD_STORE_DIR=~/.pass/marvel pass'
alias passmenumarvel='PASSWORD_STORE_DIR=~/.pass/marvel passmenu'
export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin:/opt/texlive/2017/bin/x86_64-linux:~/ellcc/bin:/home/ado/esp/xtensa-esp32-elf/bin
export ESP_ROOT=/home/ado/git/esp-open-sdk
export IDF_PATH=/home/ado/esp/esp-idf
alias mips-ecc="ecc -target mips32r2el-linux"
for c in cp rm chmod chown rename; do 
    alias $c="$c -v" 
done

# Sufix aliases
alias -s pdf="dn zathura"
alias -s doc="dn abiword"
alias -s tar="tar -xvf"
alias -s {ba,com,url,html,net,org,to}="dn $BROWSER"
alias -s {conf,txt,rc,c,h}=$EDITOR
alias -s {jpg,jpeg,png,tif,gif,svg}="dn $VIEWER"
alias -s {mp3,mp4,avi,mkv,webm,ogg,ogv,rmvb,3gp,flv}="dn $PLAYER"
#}}}

### Bindkeys ###
#{{{
# Search backward in the history for a line beginning with the current
# line up to the cursor and move the cursor to the end of the line then
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end  history-search-end
#k# search history backward for entry beginning with typed text
bindkey '^xp'   history-beginning-search-backward-end
#k# search history forward for entry beginning with typed text
bindkey '^xP'   history-beginning-search-forward-end
#k# search history backward for entry beginning with typed text
bindkey "\e[5~" history-beginning-search-backward-end # PageUp
#k# search history forward for entry beginning with typed text
bindkey "\e[6~" history-beginning-search-forward-end  # PageDown
# also do history expansion on space
bindkey ' ' magic-space 		
#}}}

### Functions ###
#{{{

##Executes by every cd
function chpwd() {
	ls
	print -Pn "\e]2;%~\a"
}

##Replace " " with "_"
function s2l() { 
for file in *; do
  \mv $file ${file:gs/\ /_/}
done
}

function dn() {
	dtach -n "/tmp/.$1.$$" $@
}

function d() {
	dtach -A "/tmp/.$1.$$" $@
}	

is42(){
    [[ $ZSH_VERSION == 4.<2->* || $ZSH_VERSION == <5->* ]] && return 0
    return 1
}
#}}}

### Misc options ###
#{{{

#eval `dircolors /etc/dir_colors`

REPORTTIME=5 				# report about cpu-/system-/user-time of
    					# command  if running longer than 5 seconds
autoload -U compinit && compinit	# completion
autoload -U colors && colors		# colors are good
autoload -U zmv				# cool mv function
setopt alwaystoend             		# when complete from middle, move cursor
setopt auto_cd		       		# change dirs without cd
setopt autopushd               		# automatically append dirs to the push/pop list
setopt c_bases				# 0xFF
setopt completealiases			# completion with aliases
setopt completeinword          		# not just at the end
setopt correct		       		# spelling correction
setopt extendedglob            		# weird & wacky pattern matching - yay zsh!
setopt hash_list_all			# rehash on completion
setopt histignorespace			# history ignores commands following whitespace
setopt inc_append_history		# append history to $HISTFILE
setopt listpacked              		# compact completion lists
setopt listtypes               		# show types in completion
setopt multios				# Allow Multiple pipes
setopt nobeep                  		# I hate beeps
setopt nocheckjobs             		# don't warn me about bg processes when exiting
setopt nohup                   		# and don't kill them, either
setopt nopromptcr              		# don't add \r which overwrites cmd output with no \n
setopt notify				# Notify when jobs finish
setopt printexitvalue          		# alert me if something's failed
setopt pushdignoredups         		# and don't duplicate them
setopt share_history			# share history betwen sessions
#}}}

### Completion System ###
# completion system# {{{
# called later (via is4 && grmlcomp)
# note: use 'zstyle' for getting current settings
#         press ^xh (control-x h) for getting tags in context; ^x? (control-x ?) to run complete_debug with trace output
grmlcomp() {
    # TODO: This could use some additional information
    # source /home/ado/.config/zsh/pass_compl.zsh

    # Make sure the completion system is initialised
    (( ${+_comps} )) || return 1

    # allow one error for every three characters typed in approximate completer
    zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

    # don't complete backup files as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'

    # start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:correct:*'       insert-unambiguous true
    zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
    zstyle ':completion:*:correct:*'       original true

    # activate color-completion
    zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

    # format on completion
    zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

    # automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
    # zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

    # insert all expansions for expand completer
    zstyle ':completion:*:expand:*'        tag-order all-expansions
    zstyle ':completion:*:history-words'   list false

    # activate menu
    zstyle ':completion:*:history-words'   menu yes

    # ignore duplicate entries
    zstyle ':completion:*:history-words'   remove-all-dups yes
    zstyle ':completion:*:history-words'   stop yes

    # match uppercase from lowercase
    #zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'

    # separate matches into groups
    zstyle ':completion:*:matches'         group 'yes'
    zstyle ':completion:*'                 group-name ''

    if [[ "$NOMENU" -eq 0 ]] ; then
        # if there are more than 5 options allow selecting from a menu
        zstyle ':completion:*'               menu select=5
    else
        # don't use any menus at all
        setopt no_auto_menu
    fi

    zstyle ':completion:*:messages'        format '%d'
    zstyle ':completion:*:options'         auto-description '%d'

    # describe options in full
    zstyle ':completion:*:options'         description 'yes'

    # on processes completion complete all user processes
    zstyle ':completion:*:processes'       command 'ps -au$USER'

    # offer indexes before parameters in subscripts
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # provide verbose completion information
    zstyle ':completion:*'                 verbose true

    # recent (as of Dec 2007) zsh versions are able to provide descriptions
    # for commands (read: 1st word in the line) that it will list for the user
    # to choose from. The following disables that, because it's not exactly fast.
    zstyle ':completion:*:-command-:*:'    verbose false

    # set format for warnings
    zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'

    # define files to ignore for zcompile
    zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
    zstyle ':completion:correct:'          prompt 'correct to: %e'

    # Ignore completion functions for commands you don't have:
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

    # Provide more processes in completion of programs like killall:
    zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

    # complete manual by their section
    zstyle ':completion:*:manuals'    separate-sections true
    zstyle ':completion:*:manuals.*'  insert-sections   true
    zstyle ':completion:*:man:*'      menu yes select

    # Search path for sudo completion
    zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                               /usr/local/bin  \
                                               /usr/sbin       \
                                               /usr/bin        \
                                               /sbin           \
                                               /bin            \
                                               /usr/X11R6/bin

    # provide .. as a completion
    zstyle ':completion:*' special-dirs ..

    # run rehash on completion so new installed program are found automatically:
    _force_rehash() {
        (( CURRENT == 1 )) && rehash
        return 1
    }

    ## correction
    # some people don't like the automatic correction - so run 'NOCOR=1 zsh' to deactivate it
    if [[ "$NOCOR" -gt 0 ]] ; then
        zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _files _ignored
        setopt nocorrect
    else
        # try to be smart about when to use what completer...
        setopt correct
        zstyle -e ':completion:*' completer '
            if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
                _last_try="$HISTNO$BUFFER$CURSOR"
                reply=(_complete _match _ignored _prefix _files)
            else
                if [[ $words[1] == (rm|mv) ]] ; then
                    reply=(_complete _files)
                else
                    reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
                fi
            fi'
    fi

    # command for process lists, the local web server details and host completion
    zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'

    # caching
    [[ -d $ZSHDIR/cache ]] && zstyle ':completion:*' use-cache yes && \
                            zstyle ':completion::complete:*' cache-path $ZSHDIR/cache/

    # host completion
    if is42 ; then
        [[ -r ~/.ssh/known_hosts ]] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
    else
        _ssh_hosts=()
        _etc_hosts=()
    fi
    hosts=(
        $(hostname)
        "$_ssh_hosts[@]"
        "$_etc_hosts[@]"
        localhost
    )
    zstyle ':completion:*:hosts' hosts $hosts
    # TODO: so, why is this here?
    #  zstyle '*' hosts $hosts

    # use generic completion system for programs not yet defined; (_gnu_generic works
    # with commands that provide a --help option with "standard" gnu-like output.)
    for compcom in cp deborphan df feh fetchipac gpasswd head hnb ipacsum mv \
                   pal stow tail uname ; do
        [[ -z ${_comps[$compcom]} ]] && compdef _gnu_generic ${compcom}
    done; unset compcom

    # see upgrade function in this file
    compdef _hosts upgrade
}
grmlcomp
#}}}

### Prompt ###
#{{{
#prompt by hound
PS1=$'%{\e[1;34m%}%n %{\e[0m%}at %{\e[0;33m%}%M %{\e[0m%}in %{\e[1;32m%}%~ 
%{\e[1;34m%}\\ %{\e[0m%}'
#}}}

# vim:sw=4:ft=zsh:fdm=marker
alias ll='ls -la'
