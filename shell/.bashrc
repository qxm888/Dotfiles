export PATH="/usr/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# OpenClaw Completion
[ -f "/home/dovahkiin/.openclaw/completions/openclaw.bash" ] && source "/home/dovahkiin/.openclaw/completions/openclaw.bash"

. "$HOME/.local/bin/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/dovahkiin/.lmstudio/bin"
# End of LM Studio CLI section

