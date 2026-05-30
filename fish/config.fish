if status is-interactive
    # Commands to run in interactive sessions can go here
end


#alias ss = 'bash ~/.config/hypr/auto-snapshots.sh'

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/dovahkiin/.lmstudio/bin
# End of LM Studio CLI section

# OpenClaw Completion
test -f "/home/dovahkiin/.openclaw/completions/openclaw.fish"; and source "/home/dovahkiin/.openclaw/completions/openclaw.fish"

