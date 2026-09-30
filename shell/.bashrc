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

. "$HOME/.cargo/env"

# 直接敲 `opencode` 就在共享工作目录 /srv/work 里启动，并自动续上次会话
# （/srv/work 是 @work 共享子卷，Gentoo 与 Arch 同路径挂载 → 会话历史两边互通）
# 带参数时原样透传，例如：opencode session list / opencode models / opencode --version
# 注：默认 agent 由 ~/.config/opencode/ 配置决定，V2 根命令不支持 --agent
opencode() {
	if [ "$#" -eq 0 ] && mountpoint -q /srv/work 2>/dev/null; then
		( cd /srv/work && command opencode --continue )
	else
		command opencode "$@"
	fi
}
