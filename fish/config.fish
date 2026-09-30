if status is-interactive
    # Commands to run in interactive sessions can go here
end


#alias ss = 'bash ~/.config/hypr/auto-snapshots.sh'

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/dovahkiin/.lmstudio/bin
# End of LM Studio CLI section

# OpenClaw Completion
test -f "/home/dovahkiin/.openclaw/completions/openclaw.fish"; and source "/home/dovahkiin/.openclaw/completions/openclaw.fish"

export PATH="$PATH:/opt/flutter/bin"
set -x ANDROID_HOME /opt/android-sdk
set -x ANDROID_SDK_ROOT /opt/android-sdk
