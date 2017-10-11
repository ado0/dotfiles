# Zsh env variables

# Default apps
EDITOR=vim
BROWSER=vimb
PLAYER=mpv
VIEWER=sxiv
# Path
#PATH="/usr/sbin/:/usr/lib/ccache/bin/:$PATH"

# Correction prompt
SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r?$reset_color (y,n,a,e) "

# History file
HISTSIZE=2000
HISTFILE=~/.zsh_history
SAVEHIST=2000
HISTCONTROL=erasedups
#Misc
EXITCODE="%(?..%?%1v )"
COLORTERM="yes"
CFLAGS="-march=native  -O2 -pipe -fstack-protector --param=ssp-buffer-size=4 -D_FORTIFY_SOURCE=2"
CXXFLAGS="-march=native   -O2 -pipe -fstack-protector --param=ssp-buffer-size=4 -D_FORTIFY_SOURCE=2"
LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro,--hash-style=gnu"
TZ="Europe/Sarajevo"
KEYTIMEOUT=1
export PAGER=less
export XDG_RUNTIME_DIR=~/.config
#EOF

#export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
#export QT_QPA_PLATFORM=wayland-egl

export WLC_REPEAT_RATE=50
export WLC_REPEAT_DELAY=200
